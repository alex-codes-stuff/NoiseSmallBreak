/// @description Initialize `con` struct, Define functions
if instance_number(obj_console) > 1
{
	instance_destroy(self); // Self destruct if a console already exists
}

con = {}; // This is our console's stuff! Yay!
/*
	Seriously though, if you modify the console,
	then make sure to use the con struct instead.
	Only use object variables like temporary vars
	that can be used in code for multiple events.
	
	The reason why is so that we can define
	variables like `x` or `visible` without using
	the built-in variables for objects.
	-Reycko
*/


#region Console variables
#region Others
con.open = false;
con.version = "0.2.4"
con.build = {
	release: GM_build_type == "exe", // false = test run
	compiled: code_is_compiled(),
};
con.output = ds_list_create();

con.game_guisize = [display_get_gui_width(), display_get_gui_height()];
con.guisize = [1280, 720];
con.deactivation = []; // this is used for opening and closing console
con.screenshot = -1;
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
#region Strings n stuff
con.strings = {
	game: "NBB",
	game_version: "2.25",
	top: {
		console: "Console",
		on: "on",
		gm: "GameMaker",
		builddate: "Build date",
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
		invalid_cmds: "you can see a list of commands with `cmds`",
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
};
#endregion
#region Console "enums"
con.enums = {};
con.enums.logtype =
{
	log: 0,
	warn: 1,
	error: 2,
	err: 2, // Same as "error"
	debug: 3, // Will only print in test runs
	none: 4,
}
#endregion
#region Console settings
con.settings = {
	show_debug_logs: con.build.release,
};
#endregion
#endregion
#region Console functions
#region Opening/closing console
function con_open()
{
	if (con.open) { return; }
	display_set_gui_size(con.guisize[0], con.guisize[1]);
	var _deactivation_index = [];
	var _console = id;
	with (all)
	{
		if (id != _console)
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
	if (!con.open) { return; }
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
// Inverting the arguments in this weirdly causes isues
// Feather disable once GM1056
function con_log(_type = con.enums.logtype.log, _text)
{
	_text = string(_text); // Stringification
	// If you've dealt with the trim bug, then uncomment the second line and delete the first.
	ds_list_add(con.output, [_type, date_current_datetime(), string_replace(_text, "\n", " ")]);
	//ds_list_add(con.output, [_type, date_current_datetime(), _text]);
}
#endregion
#region Adding commands + Error handler

/// @function					con_error_handler(exception)
///	@description				Default error handler for console commands. Logs to console as an error
/// @param		{Struct}	_e	Exception struct.
function con_error_handler(_e)
{
	con_log(con.enums.logtype.err, $"Couldn't add command: {_name}: {string(_e)}");
}

/// @function										con_add_command(name, description, function, aliases)
/// @description									Add a console command.
///													If success, returns true, else returns the exception struct.
/// @param			{String}		_name			The name of the command to add.
/// @param			{String}		_description	Describe the command.
/// @param			{Function}		_func			The function to execute. Add "_args" as a 
///													parameter to get command arguments.
/// @param			{Array.String}	_aliases		Other names for the command.
/// @param			{Function}		_err_handler	Custom error handler if an exception occurs.
///													Note that executing from the console will always try-catch.
/// @return			{Bool | Struct}					
function con_add_command(_name, _description, _func, _aliases = [], _err_handler = con_error_handler)
{
	_name = string_lower(_name)
	try
	{
		con.commands.data[$ _name] = {
			description: _description,
			func: _func,
		};
		
		for (var i = 0; i < array_length(_aliases); i++)
		{
			_aliases[i] = string_lower(_aliases[i]);
			con.commands.aliases[$ _aliases[i]] = _name; // Example: alias "a" for "b" -> con.commands.aliases.a = "b";
		}
		return true;
	} 
	catch (_e) 
	{
		_err_handler(_e);
		return _e;
	}
}
#endregion
#region Others
/// @function								con_get_arg_safe(arguments, index, cleanup = true)
///	@description							Safely get the wanted argument.
/// @param		{Array.String}	_args		Contents of the command's `_args`.
/// @param		{Real}			_index		Index of the array to safety grab the argument of.
///	@param		{Bool}			_cleanup	Clean up strings to prevent issues with how the console works.
/// @returns	{Undefined,Any}				If undefined, return undefined as well + log to console, else, the wanted argument,
///											clean if _cleanup is true.
function con_get_arg_safe(_args, _index, _cleanup = true)
{
	if (_index >= array_length(_args)) { con_log(con.enums.logtype.err, $"Missing argument {string(_index)}"); return undefined; }
	if (is_undefined(_args[_index])) { con_log(con.enums.logtype.err, $"Invalid argument {string(_index)}"); return undefined; }
	var _val = _args[_index];
	if (is_string(_val) && _cleanup)
	{
		_val = string_replace_all(_val, "|", "");
	}
	return _val;
}

/// @function						string_is_number(string)
/// @description					Returns whether or not said string is a valid number.
/// @param		{String}	_str	The input string.
///	@returns	{Bool}				Whether or not said string is a valid number.
function string_is_number(_str)
{
	return string_digits(_str) != "";
}

/// @function						string_to_number(string)
/// @description					Returns a number based on string as input. Returns false if it is not a number.
/// @param		{String}	_str	Input string.
/// @returns	{Real | Bool}		If number, the converted number, else false.
function string_to_number(_str)
{
	if !string_is_number(_str) { return false; }
	var _negative = string_char_at(_str, 1) == "-";
	return _negative ? -real(string_digits(_str)) : real(string_digits(_str));
}
#endregion
#endregion
#region CONSOLE COMMANDS
//con.commands = ds_map_create(); // Old system used DS maps
con.commands = {
	data: {},
	aliases: {},
};

con_add_command("cmds", "List of commands. Call on a command to see it's description.", function(_args)
{
	var _ret = "";
	for (var i = 0; i < array_length(struct_get_names(con.commands.data)); i++)
	{
		_ret += $"{struct_get_names(con.commands.data)[i]}, ";
	}
	_ret = string_copy(_ret, 1, string_length(_ret) - 2);
	con_log(con.enums.logtype.log, _ret);
}, ["help", "commands"]);


con_add_command("quit", "Exits the game.", function(_args) 
{
	game_end(); 
}, ["exit", "stop"]);
con_add_command("restart", "Restarts the game.", function(_args) 
{ 
	game_restart(); 
}, ["reboot"]);
con_add_command("time", "Shows date_current_datetime() and it's string result.", function(_args)
{
	return $"{date_current_datetime()}|{date_datetime_string(date_current_datetime())}";
});

con_add_command("aliases", "Lists all aliases.", function(_args)
{
	var _return = "";
	_ret = "";
	struct_foreach(con.commands.aliases, function(_key, _value)
	{
		_ret += $"{_key} -> {_value}; ";
	});
	_return = string_copy(_ret, 1, string_length(_ret) - 2);
	_ret = undefined;
	return _return;
}, ["alias"]);

con_add_command("clear", "Clears console.", function(_args)
{
	ds_list_clear(con.output);
	return ds_list_empty(con.output);
}, ["cls"]);

con_add_command("speed", "Get or adjust game speed.", function(_args)
{
	var _type = con_get_arg_safe(_args, 1);
	if (is_undefined(_type)) { return; }
	if (string_pos(_type, "set|get") == 0) { con_log(con.enums.logtype.err, "Invalid argument 1"); return; }
	var _mode = con_get_arg_safe(_args, 2);
	if (is_undefined(_mode)) { return; }
	if (string_pos(_mode, "fps|us") == 0) { con_log(con.enums.logtype.err, "Invalid argument 2"); return; }
	_mode = _mode == "fps" ? gamespeed_fps : gamespeed_microseconds;
	var _to = undefined; // Ironically defining as undefined
	if (_type == "set")
	{
		_to = con_get_arg_safe(_args, 3);
		if (is_undefined(_to)) { return; }
		_to = string_to_number(_to);
		if (_to == false) { con_log(con.enums.logtype.err, "Invalid argument 3"); return; }
	}
	
	switch (_type)
	{
		case "set":
			game_set_speed(_to, _mode);
			return game_get_speed(_mode) == _to;
		break;
		case "get":
			return game_get_speed(_mode);
		break;
	}
});

if (!is_undefined(live_enabled) && live_enabled)
{
	con_add_command("eval", "Run a command live using GMLive.", function(_args)
	{
		var _args2 = [];
		array_copy(_args2, 0, _args, 1, array_length(_args) - 1);
		var _call = "";
		for (var i = 0; i < array_length(_args2); i++)
		{
			_call += $"{_args2[i]} ";
		}
		_call = string_copy(_call, 1, string_length(_call) - 1); // Remove trailing space
		if (live_execute_string(_call)) { return live_result; } else { con_log(con.enums.logtype.err, $"Command failed to execute: {string(live_result)}"); }
	});
}

con_add_command("crash", "Simulates a game crash.", function(_args)
{
    _exception_unhandled_handler({
        message: "Manually initiated crash",
        longMessage: "Long message; Manually initiated crash.",
        script: "scr_script_location",
        line: 42,
        stacktrace: ["scr_script_1", "scr_script_2"],
    })
    game_end();
});

con_add_command("sex", "Alex I swear to fucking go-", function(_args)
{
	url_open("https://www.youtube.com/watch?v=I_y3PLiCa6A"); // Meatophobia
	game_end();
});

/*
// TEMPLATE COMMAND
con_add_command("mycommand", "Example command!", function(_args)
{
	show_message("I'm such a silly function!");
	con_log(con.enums.logtype.log, string(_args)); // Prints out all arguments including command
}, ["alias1", "alias2"], // You can now call "mycommand" using "alias1" or "alias2"
function(_e) // Optional argument, error handler.
{
	show_message("This is a custom error handler!");
	show_message($"Exception: {string(_e)}");
});
*/
#endregion