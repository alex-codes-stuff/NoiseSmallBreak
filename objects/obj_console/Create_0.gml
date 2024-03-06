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
con.version = "0.15"
con.build = {
	release: GM_build_type == "exe", // false = test run
	compiled: code_is_compiled(),
};
con.output = ds_list_create();

con.deactivation = []; // this is used for opening and closing console
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
#endregion
#region Console functions
#region Opening/closing console
function con_open()
{
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
	con.deactivation = _deactivation_index;
}

function con_close()
{
	for (var i = 0; i < array_length(con.deactivation); i++)
	{
		instance_activate_object(con.deactivation[i]);
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
#region Adding/removing commands + Error handler

/// @function					con_error_handler(exception)
///	@description				Default error handler for console commands. Logs to console as an error.
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
/// @param			{Array}			_aliases		Other names for the command.
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
#endregion
#region CONSOLE COMMANDS
//con.commands = ds_map_create(); // Old system used DS maps
con.commands = {
	data: {},
	aliases: {},
};

con_add_command("cmds", "List of commands.", function(_args)
{
	var _ret = "";
	for (var i = 0; i < array_length(struct_get_names(con.commands.data)); i++)
	{
		_ret += $"{struct_get_names(con.commands.data)[i]}, ";
	}
	_ret = string_copy(_ret, 1, string_length(_ret) - 2);
	con_log(con.enums.logtype.log, _ret);
}, ["help", "commands"]);

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

/*
// TEMPLATE COMMAND
con_add_command("mycommand", "Example command!", function(_args)
{
	show_message("I'm such a silly function!");
	con_log(con.enums.logtype.log, string(_args)); // Prints out all arguments including command
}, function(_e)
{
	show_message("This is a custom error handler!");
	show_message($"Exception: {string(_e)}");
});
*/
#endregion
