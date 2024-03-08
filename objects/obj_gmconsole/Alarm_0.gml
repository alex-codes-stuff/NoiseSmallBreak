/// @description Built-in commands
// DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING!
// Feather disable GM1019
// Feather disable GM1020

con_add_command(new ConCommandMeta
(
	"help", // ConCommandMeta: name
	"Lists all commands. Call on a command to see it's description.", // ConCommandMeta: description
	[
		new ConCommandArg("command", "string", "Specific command to get information about.", true), // ConCommandMeta: arguments (Array of `ConCommandArg`s). This is arg 1
		//new ConCommandArg("example_optional_arg", "bool", true)
	], 
	["cmds", "commands"] // ConCommandMeta: aliases
), 

function(_args, _arg_count) // Function
{
	if (_arg_count < 1) // No arguments provided
	{
		var _ret = "";
		for (var i = 0; i < struct_names_count(con.commands.funcs); i++)
		{
			_ret += $"{struct_get_names(con.commands.funcs)[i]}, ";
		}
		_ret = string_copy(_ret, 1, string_length(_ret) - 2);
		return _ret;
	}
	else
	{
		var _ret = "";
		var _cmd = con_translate_alias(_args[1]);
		if (_cmd == false) { con_log(con.enums.logtype.err, $"Invalid command/alias was specified: `{_args[1]}`"); return "%h"; } // Using `!_cmd` would throw an error
		var _meta = con.commands.metas[$ _cmd];
		var _cmdargs = _meta.arguments;
		var _cmdargs_fmt = ""; // Formatted args
		for (var i = 0; i < array_length(_meta.arguments); i++)
		{
			
			// Feather fucked all these 2 over, so that's a good thing to note: Feather sucks with GM's "template literals"
			
			//_cmdargs_fmt += $"\t{_cmdargs[i].arg}<{_cmdargs[i].type}>{_cmdargs[i].optional ? " (optional) " : ""}{array_length(_cmdargs[i].values) >= 1 ? " (takes the following values, separated by |: `"string_join_ext("|",}{ _cmdargs[i].values}{)}`){ :}: {_cmdargs[i].description}\n";
			_cmdargs_fmt += $"\t{_cmdargs[i].arg}<{_cmdargs[i].type}>{_cmdargs[i].optional ? " (optional) " : ""}";
			_cmdargs_fmt += (array_length(_cmdargs[i].values) >= 1 ? $" (takes the following values, separated by |: `{string_join_ext("|", _cmdargs[i].values)}`) " : "");
			_cmdargs_fmt += $": {_cmdargs[i].description}\n";
		}
		
		// Same thing happened here
		//_ret = $"\n{_meta.name}: {_meta.description}\n{_meta.arguments != [] ? "Arguments: \n"_cmdargs_fmt""}{ :}Command takes no arguments\n{_meta.aliases != [] ? "Aliases: `"string_join_ext("`|`",}{ _meta.aliases}{)}`{ :}Command has no aliases";
		
		_ret = $"\n{_meta.name}: {_meta.description}\n";
		// Feather disable once GM1100
		_ret += $"{array_length(_meta.arguments) != 0 ? $"Arguments: \n{_cmdargs_fmt}" : "Command takes no arguments"}\n";
		_ret += (array_length(_meta.aliases) != 0 ? $"Aliases: `{string_join_ext("`|`", _meta.aliases)}`" : "Command has no aliases");
		return _ret;
	}
});

con_add_command(new ConCommandMeta
(
	"quit",
	"Exits the game.",
	[],
	["exit", "stop"],
), 
function(_args, _arg_count)
{
	game_end();
});

con_add_command(new ConCommandMeta
(
	"restart", 
	"Restarts the game.",
	[],
	["reboot"]
),
function(_args, _arg_count)
{
	game_restart();
});

con_add_command(new ConCommandMeta
(
	"aliases", 
	"Lists all aliases.",
), 
function(_args, _arg_count)
{
	var _ret = "";
	var _aliases = con_get_aliases();
	for (var i = 0; i < struct_names_count(_aliases); i++)
	{
		var _key = struct_get_names(_aliases)[i];
		var _value = _aliases[$ _key];
		if (array_length(_value) > 0) { _ret += $"{_key} -> `{string_join_ext("`|`", _value)}`; "; }
	}
	_ret = string_copy(_ret, 1, string_length(_ret) - 2);
	return _ret;
});

con_add_command(new ConCommandMeta
(
	"clear", 
	"Clears console.", 
	[], 
	["cls"], 
),
function(_args, _arg_count)
{
	ds_list_clear(con.output);
	return "%h"; // %h = hide "command returned" text
});

con_add_command(new ConCommandMeta
(
	"speed", 
	"Get or adjust game speed.", 
	[
		new ConCommandArg("mode", "string", "Set or get?", false, ["set", "get"]),
		new ConCommandArg("type", "string", "Perform on fps or us (microseconds)?", false, ["fps", "us", "microseconds"]),
		new ConCommandArg("set", "number", "If on set mode, value to set it to.", true),
	], 
), 
function(_args, _arg_count)
{
	if (_arg_count < 2) { con_log(con.enums.logtype.err, "Incorrect amount of arguments."); return "%h"; }
	if (!con_arg_valid(_args, 2)) { return "%h"; } // %h = hide "command returned" text, don't show as con_get_arg() already showed an error
	var _type = (_args[2] == "fps" ? gamespeed_fps : gamespeed_microseconds); // This would have make incorrect arguments still work without the return above
	var _to = (_args[1] == "set" ? _args[3] : undefined); 
	if (_args[1] == "set")
	{
		game_set_speed(_to, _type);
	}
	return game_get_speed(_type);
});

con_add_command(new ConCommandMeta
(
	"eval",
	"Run GML through the console, requires GMLive by YellowAfterlife.",
	[
		new ConCommandArg("code", "string", "The code to execute.", false, [], true),
	],
	["execute", "run"],
	true,
),
function(_args, _arg_count)
{
	if (_arg_count < 1) { con_log(con.enums.logtype.err, "Missing argument 1"); return "%h"; }
	if (asset_get_index("obj_gmlive") == -1) { return "Missing GMLive"; }
	if (is_undefined(live_enabled)) { return "Missing GMLive"; }
	try
	{
		var _exec = [];
		array_copy(_exec, 0, _args, 1, array_length(_args) - 1); // Use array copy to prevent working on the real _args + shift by 1
		live_execute_string(string_join_ext(" ", _exec));
		return live_result;
	}
	catch (_e)
	{
		var _missing_gmlive = (string_starts_with(string_lower(_e.message), "variable <unknown_object>.live_execute_string") && string_ends_with(string_lower(_e.message), "not set before reading it."));
		if (_missing_gmlive) { con_log(con.enums.logtype.err, "Missing GMLive"); return; }
		con_log(con.enums.logtype.err, _e.message);
	}
});

con_add_command(new ConCommandMeta
(
	"github", 
	"Opens the GitHub page for GMConsole.",
), function()
{
	url_open(con.github.link);
});

con_add_command(new ConCommandMeta
(
	"about", 
	"Prints GMConsole information.", 
	[], 
	["version", "ver"],
),
function()
{
	// Feather disable once GM1100
	var _ret = [
		$"GMConsole v{con.version} (Update status: {con.strings.outdated[$ con_enum_get_name("outdated", con.outdated)]}{(con.latest_version != "" && con.outdated == con.enums.outdated.yes) ? $", latest stable version is {con.latest_version}" : ""})",
		"Made with <3 by Reycko",
		$"You are on branch {con.github.branch} (based on version name)",
		"Use command `github` to open the github repo!",
	];
	
	return $"\n{string_join_ext("\n", _ret)}";
});