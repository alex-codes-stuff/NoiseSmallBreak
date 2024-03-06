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
con.version = "0.1"
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
			log: c_white,
			warn: c_yellow,
			error: c_red,
			debug: c_gray,
		},
		opacity: 0.75,
	},
	
	background: {
		color: c_black,
		opacity: 0.75,
	},
	
	separator: {
		width: 2,
		col: c_white,
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
#endregion
#region CONSOLE COMMANDS
//con.commands = ds_map_create();
con.commands = {};

con.commands.cmds = function(_args)
{
	var _ret = "";
	for (var i = 0; i < array_length(struct_get_names(con.commands)); i++)
	{
		_ret += $"{struct_get_names(con.commands)[i]}, ";
	}
	_ret = string_copy(_ret, 1, string_length(_ret) - 2);
	con_log(con.enums.logtype.log, _ret);
}

con.commands.crash = function(_args)
{
	_exception_unhandled_handler({
		message: "Manually initiated crash",
		longMessage: "Long message; Manually initiated crash.",
		script: "scr_script_location",
		line: 42,
		stacktrace: ["scr_script_1", "scr_script_2"],
	})
	game_end();
}

con.commands.quit = function(_args)
{
	game_end();
}

con.commands.restart = function(_args)
{
	game_restart();
}

con.commands.time = function(_args)
{
	con_log(con.enums.logtype.log, $"{date_current_datetime()} | {date_datetime_string(date_current_datetime())}");
}

/*
// TEMPLATE COMMAND
con.commands.mycommand = function(_args)
{
	con_log("My command is called");
	// Do stuff here.
	// You should add a con_log at the command for responsiveness.
}
*/
#endregion
