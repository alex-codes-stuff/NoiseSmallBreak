/// @description Initialize `con` struct, Define functions
if instance_number(obj_gmconsole) > 1
{
	instance_destroy(self); // Self destruct if a console already exists
}

con = {}; // This is our console's struct!
/*
	If you modify/add internal variables, then make sure to define your 
	vars in the `con` struct.
	
	Only use object variables like temporary vars that can be used in 
	code for multiple events, or in between a *_foreach() function.
	
	The reason is for us to be able to define vars like `x` or `visible` 
	without using the built-in variables for objects. -Reycko
*/

/* 
	Note: If you change the name of this object, PLEASE disable Feather's 
	"Refactor references to asset name when asset is renamed in Asset Browser"
	option (it breaks strings), also make sure to change the `gmc` macro 
	in `gmconsole_init`.
	
	I learnt this the hard way when changing it's name from obj_console to 
	obj_gmconsole in 0.3.00.00 lol
*/
// Settings at region: Console variables -> Console settings
#region Console variables
#region Others (pre-enum)
global.__con = id;
con.open = false;
con.hasgmlive = asset_get_index("obj_gmlive") != -1
con.version = "0.3.00.03-dev";
con.latest_version = "";
con.github = {
	link: "https://github.com/Reycko/GMConsole",
	branch: (con_is_stable(con.version) ? "stable" : "master"),
}
con.github.get_req = { // Defining it right after defining con.github is important to avoid a crash w `link`
	link: $"https://raw.github.com/Reycko/GMConsole/{con.github.branch}/ver.txt",
	req: undefined,
}

con.build = {
	release: GM_build_type == "exe", // false = test run
	compiled: code_is_compiled(),
};
con.output = ds_list_create();
con.online = os_is_network_connected(network_connect_passive);
con.game_guisize = [display_get_gui_width(), display_get_gui_height()];
con.guisize = [1280, 720];
con.deactivation = []; // this is used for opening and closing console
con.screenshot = -1;
con.easteregg = {
	konami: 0,
}
#endregion
#region Console UI customization
con.ui = {
	text: {
		colors: {
			// Would name "def" default but that's reserved
			def: c_white, // Default color for stuff like top bar or cmdbar
		},
		opacity: 0.75,
		output: {
			colors: {
				log: c_white,
				warn: c_yellow,
				error: c_red,
				debug: c_gray,
			},
			opacity: 1,
		},
	},
	
	background: {
		color: c_black,
		opacity: 0.75,
	},
	
	separator: {
		width: 2,
		col: c_white,
		opacity: 0.5,
	},
	top: {
		colors: {
			outdated: {
				unknown: c_yellow,
				yes: c_red,
				no: c_white,
				offline: c_gray,
			},
		},
	},
	
	cmdbar: {
		input_bar: {
			show: true,
			width: 3,
			opacity: 1,
		},
		opacity_empty: 0.5,
		opacity: 1,
	},
};
#endregion
#region Strings
con.strings = {
	top: {
		console: "GMConsole",
		gm: "GameMaker",
		builddate: "Build date",
		updstatus: "Upd status:",
	},
	build: {
		test: "TEST",
		release: "RELEASE/VM",
		compiled: "COMPILED/YYC",
		build: "BUILD",
	},
	output: {
		log: "log",
		warn: "warn",
		error: "error",
		err: "error",
		debug: "debug",
	},
	cmdbar: {
		returned: "Command returned",
		couldnt_exec: "Couldn't execute command:",
		invalid: "Invalid command,",
		invalid_help: "you can see a list of commands with `help`",
		line: "line",
		types: {
			string: "string",
			number: "number",
			int32: "int32",
			int64: "int64",
			bool: "boolean",
			struct: "struct",
			array: "array",
			undefined: "nothing",
		},
		no_print: "Command did not print anything"
	},
	commands: {
		con_get_arg: {
			argument: "Argument",
			expected: "expected",
			got: "got",
			extra_argument: "Extra argument",
			
			con_convert_value: {
				couldnt_convert: "Couldn't convert type",
				to: "to",
			},
		},
		
		con_convert_value: {
			couldnt_convert: "Couldn't convert type",
			to: "to",
		},
	},
	outdated: {
		unknown: "Unknown",
		yes: "OUTDATED",
		no: "Up to date",
		offline: "Offline",
	},
};
#endregion
#region Console "enums"
con.enums = {
	logtype: {
		log: 0,
		warn: 1,
		error: 2,
		err: 2, // Same as "error"
		debug: 3, // Will only print if show_debug_logs is true in settings
		none: 4,
	},
	outdated: {
		unknown: 0,
		yes: 1,
		no: 2,
		offline: 3,
	},
};
#endregion
#region Console settings
con.settings = {
	show_debug_logs: !con.build.release, // Show logs with the debug type
	can_open: true, // If false, console cannot be opened.
	//can_open: !con.build.release, // Uncomment if you want to disable the console on release builds
};
#region Others (post-enum)
con.outdated = con.enums.outdated.offline;
if (con.online && con.outdated == con.enums.outdated.offline)
{
	con.outdated = con.enums.outdated.unknown;
}

con.github.get_req.req = http_get(con.github.get_req.link); // Check the repo for updates
#endregion
#endregion
#endregion
#region Console functions
#region Opening/closing console
function con_open()
{
	if (con.open || !con.settings.can_open) { return; }
	display_set_gui_size(con.guisize[0], con.guisize[1]);
	var _deactivation_index = [];
	var _console = id;
	var gmlive = con.hasgmlive 
	with (all)
	{
		if (id != _console && gmlive
		&& (instance_exists(obj_gmlive) && id != instance_nearest(0, 0, obj_gmlive).id))
		{
			array_push(_deactivation_index, self);
			instance_deactivate_object(self);
		}
	}
	con.open = true;
	if (!sprite_exists(con.screenshot))
	{
		con.screenshot = sprite_create_from_surface(application_surface, 0, 0, view_wport[view_current], view_hport[view_current], false, false, 0, 0);
	}
	con.deactivation = _deactivation_index;
}

function con_close()
{
	if (!con.open || !con.settings.can_open) { return; }
	display_set_gui_size(con.game_guisize[0], con.game_guisize[1]);
	for (var i = 0; i < array_length(con.deactivation); i++)
	{
		instance_activate_object(con.deactivation[i]);
	}
	if (sprite_exists(con.screenshot))
	{
		sprite_delete(con.screenshot);
	}
	con.open = false;
}
#endregion
#region Log to console
// Feather disable once GM1056
/// @param	{Struct.con.enums.logtype}	_type
/// @param	{Any}						_text
function con_log(_type = con.enums.logtype.log, _text)
{
	_text = string(_text); // Stringification
	// If you've dealt with the trim bug, then uncomment the second line and delete the first.
	//ds_list_add(con.output, [_type, date_current_datetime(), string_replace(_text, "\n", " ")]);
	ds_list_add(con.output, [_type, date_current_datetime(), _text, true]);
	//array_push(global.debuglog, $"con_log: {_text}");
}
#endregion
#region Constructors

/// @param	{String}				_arg			The name of the argument.
/// @param	{String}				_type			The argument's type. The console will use typeof.
/// @param	{String}				_description	The description for your argument. Used by `cmds` to give a description.
/// @param	{Bool}					_optional		Whether this is an optional argument.
/// @param	{Array<Any>}			_values			Accepted values, leave blank to allow anything (of the specified type).
function ConCommandArg(_arg, _type, _description, _optional = false, _values = []) constructor
{
	arg = _arg;
	var _newtype = _type;
	if (_newtype == "real") { _newtype = "number"; } // Prevent typoing number as real
	if (!array_contains(["string", "all", "number", "int64", "struct", "any"], _newtype)) { con_log(con.enums.logtype.warn, $"A command tried to use invalid type {_type}, so it was changed to `any`."); _newtype = "any"; }
	type = _newtype; 
	description = _description;
	optional = _optional;
	values = _values;
}
/// @param	{String}						_name				Command name.
/// @param	{String}						_description		Command description.
/// @param	{Array<Struct.ConCommandArg>}	_arguments			Arguments for the command.
/// @param	{Array<String>}					_aliases			Command aliases.
/// @param	{Bool}							_allow_extra_args	If true, will allow extra arguments.
function ConCommandMeta(_name, _description, _arguments = [], _aliases = [], _allow_extra_args = false) constructor
{
	name = string_replace_all(_name, " ", "_");
	description = _description;
	arguments = _arguments;
	aliases = _aliases;
	allow_extra_args = _allow_extra_args;
}
#endregion
#region Command-related functions
/// @function												con_add_command(name, description, function, aliases)
/// @description											Add a console command. If the command already exists, an error is logged to the console.
/// @param			{Struct.ConCommandMeta}	_meta			The name of the command to add.
/// @param			{Function}				_func			The function to execute. Add an argument as a 
///															parameter to get command arguments.
/// @return			{Bool}									Whether the command has been successfully added.
function con_add_command(_meta, _func)
{
	if (struct_exists(con.commands.funcs, _meta[$ "name"]))
	{ 
		con_log(con.enums.logtype.err, $"Cannot have 2 commands of the same name: {_meta[$ "name"]}"); 
		return false; 
	}
	
	con.commands.metas[$ _meta[$ "name"]] = _meta;
	con.commands.funcs[$ _meta[$ "name"]] = _func;
	return true;
}
#endregion
#region Others
#region Enum functions
// Fun fact: I spent a whole minute thinking whether I should type "behaviour" (UK English) or "behavior" (US English)
/// @description			Might result in odd behaviour if the enum has multiple keys with the same value.
/// @param		{String}	_enum
/// @param		{Any}		_val
/// @returns	{Any}
function con_enum_get_name(_enum, _val)
{
	//var con = global.__con.con;
	if (!struct_exists(con, "enums")) { return; }
	var _inv_struct = {};
	var _struct = con.enums[$ _enum];
	for (var i = 0; i < struct_names_count(_struct); i++)
	{
		var _k = struct_get_names(_struct)[i];
		var _v = struct_get(_struct, _k);
		_inv_struct[$ _v] = _k;
	}
	
	return _inv_struct[$ _val];
}
#endregion
/// @param		{Array<String>}	_args		Contains arguments, make them strings, they will be converted.
/// @returns	{Any}						Success => Command's return; Fail => undefined
function con_call_command(_args = [])
{
	try
	{
		//var _cur_output_size = ds_list_size(con.output) + 1;
		con_log(con.enums.logtype.none, $">{string_join_ext(" ", _args)}");
		// Feather disable once GM2016
		var _cmdargs = [];
		array_copy(_cmdargs, 0, _args, 0, array_length(_args));
		_cmdargs[0] = con_translate_alias(_cmdargs[0]);
		if (!struct_exists(con.commands.funcs, _cmdargs[0])) { con_log(con.enums.logtype.err, $"{con.strings.cmdbar.couldnt_exec} {con.strings.cmdbar.invalid} {con.strings.cmdbar.invalid_help}"); return undefined; }
		try // Silently fail if extra args are provided
		{
			for (var i = 1; i < array_length(_cmdargs); i++)
			{
				_cmdargs[i] = con_get_arg(_cmdargs, i);
			}
		}
		var _ret = con.commands.funcs[$ _cmdargs[0]](_cmdargs, array_length(_cmdargs) - 1);
		//if _cur_output_size == ds_list_size(con.output) { con_log(con.enums.logtype.log, $"{con.strings.cmdbar.no_print}"); }
		// Feather disable once GM1100
		// Feather disable once GM1063
		// Feather disable once GM1012
		if (_ret != "%h") { con_log(con.enums.logtype.log, $"{con.strings.cmdbar.returned} {(array_contains(["string","number","int64","bool","struct","array"], typeof(_ret)) ? $"{con.strings.cmdbar.types[$ typeof(_ret)]}: {string(_ret)}" : (typeof(_ret) == "undefined" ? con.strings.cmdbar.types.undefined : typeof(_ret)))}"); } // Woah this line is atrociously long
		return _ret;
	}
	catch (e)
	{
		var _invalid_cmd = string_ends_with(e.message, "Invalid callv target #2"); //TODO: More consistent method
		// Feather disable once GM1063
		// Feather disable once GM1100
		con_log(con.enums.logtype.err, $"{con.strings.cmdbar.couldnt_exec} {_invalid_cmd ? $"{con.strings.cmdbar.invalid} {con.strings.cmdbar.invalid_help}" : $"{e.message} @ {e.script} {con.strings.cmdbar.line} {e.line}"}");
		return undefined;
	}
}

/// @param		{String}	_val		Input value.
/// @param		{String}	_to			Tries to convert _val to this.
/// @returns	{Any}
function con_convert_value(_val, _to)
{
	try
	{
		switch (_to)
		{
			case "string": return string(_val);
			case "string_all": return string(_val);
			case "number": return real(string_to_number(_val));
			case "int64": return int64(_val);
			case "struct": return json_parse(_val);
			case "any": return _val;
		}
	}
	/*con_log(con.enums.logtype.err, $"con_convert_value(): Invalid or unsupported type `{_to}`.");
	return undefined;*/
	catch (_e)
	{
		con_log(con.enums.logtype.debug, $"con_convert_value(): {con.strings.commands.con_convert_value.couldnt_convert} {typeof(_val)} {con.strings.commands.con_convert_value.to} `{_to}`.");
		return undefined;
	}
}

/// @param	{Array}		_args		Arguments array.
/// @param	{Real}		_index		Index of the array to check.
/// @returns {Bool}
function con_arg_valid(_args, _index)
{
	var _meta = con.commands.metas[$ _args[0]];
	if (_index > array_length(_args) - 1) { return false; }
	var _arg_meta = _meta.arguments[_index - 1];
	if (array_length(_arg_meta.values) >= 1)
	{
		if (!array_contains(_arg_meta.values, _args[_index])) { return false; }
	}
	return true;
}

/// @description							Note: this command is no longer necessary, as con_call_command calls this on all args.
///											Note 2: This does NOT account for missing arguments, you will need to check this.
/// @param		{Array<String>}	_args		Contents of the command's `args` array.
/// @param		{Real}			_index		Index of the args array to get the value from.
/// @returns	{Any}						argument, converted based on it's meta.
function con_get_arg(_args, _index)
{
	// TODO: Implement this in a way that `args` directly gives these! (Step code?)
	// TODO: Convert all the text here to con.strings
	var _meta = con.commands.metas[$ _args[0]];
	if (_index >= array_length(_meta.arguments) + 1  && !_meta.allow_extra_args) { con_log(con.enums.logtype.warn, $"{con.strings.commands.con_get_arg.extra_argument} {_index}"); return undefined; } // Extra args
	else if (_index >= array_length(_meta.arguments) + 1 && _meta.allow_extra_args) { return _args[_index]; }
	var _arg_meta = _meta.arguments[_index - 1];
	
	if (_index == 0) { return _arg_meta.name; }
	if (_index >= array_length(_args)) { con_log(con.enums.logtype.err, $"{con.strings.commands.con_get_arg.argument} {_index}: {con.strings.commands.con_get_arg.expected} {_arg_meta.type}"); return undefined; }
	if (is_undefined(_args[_index])) { con_log(con.enums.logtype.err, $"{con.strings.commands.con_get_arg.argument} {_index}: {con.strings.commands.con_get_arg.expected} {_arg_meta.type}"); return undefined; }
	
	var _arg = con_convert_value(_args[_index], _arg_meta.type);
	if (typeof(_arg) == "undefined" && (string_pos(_arg_meta.type, "undefined|any") != 0) && !_arg_meta.optional) { con_log(con.enums.logtype.err, $"{con.strings.commands.con_get_arg.argument} {_index}: {con.strings.commands.con_get_arg.expected} {_arg_meta.type}, {con.strings.commands.con_get_arg.got} {typeof(_args[_index])}"); return undefined; }
	if (typeof(_arg) != _arg_meta.type) { con_log(con.enums.logtype.err, $"{con.strings.commands.con_get_arg.argument} {_index}: {con.strings.commands.con_get_arg.expected} {_arg_meta.type}, {con.strings.commands.con_get_arg.got} {typeof(_arg)}"); return undefined; }
	
	if (array_length(_arg_meta.values) >= 1)
	{
		if (!array_contains(_arg_meta.values, _arg)) { con_log(con.enums.logtype.err, $"{con.strings.commands.con_get_arg.argument} {_index}: {con.strings.commands.con_get_arg.expected} `{string_join_ext("`|`", _arg_meta.values)}`, {con.strings.commands.con_get_arg.got} {_arg}"); return undefined; }
	}
	
	return _arg;
}

/// @returns	{Struct}
function con_get_aliases()
{
	var _ret = {};
	var _metas = con.commands.metas;
	for (var i = 0; i < struct_names_count(_metas); i++)
	{
		var key = struct_get_names(_metas)[i];
		var value = struct_get(_metas, key);
		_ret[$ key] = value[$ "aliases"];
	}
	return _ret;
}

/// @param		{String}		_alias
/// @returns	{String | Bool}
function con_translate_alias(_alias)
{
	if (variable_instance_exists(self, con.commands.funcs[$ _alias]) || !is_undefined(con.commands.funcs[$ _alias])) { return _alias; } // Is already the actual name
	_ret = _alias;
	struct_foreach(con_get_aliases(), function(_key, _value)
	{
		for (var i = 0; i < array_length(_value); i++)
		{
			var _check = _value[i];
			if (string_lower(_ret) == string_lower(_check))
			{
				_ret = _key;
			}
		}
	});
	
	var __ret = _ret;
	_ret = undefined;
	return (__ret == _alias ? false : __ret);
}

/// @param		{String}	_str	The input string.
///	@returns	{Bool}				Whether or not said string is a valid number.
function string_is_number(_str)
{
	return string_digits(_str) != "";
}

/// @param		{String}		_str	Input string.
/// @returns	{Real | Bool}			If number, the converted number, else false.
function string_to_number(_str)
{
	if !string_is_number(_str) { return false; }
	var _negative = string_char_at(_str, 1) == "-";
	return _negative ? -real(string_digits(_str)) : real(string_digits(_str)); //TODO: Make this use math instead of an ternary (optimization)
}

// con_is_stable() in gmconsole_init for it to be initialized before obj_gmconsole
#endregion
#endregion

#region Define commands struct and load commands
con.commands = {
	funcs: {},
	metas: {},
};

event_perform(ev_alarm, 0); // Load built-in commands
script_execute(con_user_console_commands); // Load custom commands
#endregion