// The function "con_user_console_commands()" will be called as soon as the built-in commands are loaded.
// VVVVVVVVVVVVVVVVVVVVVV These bug out if you make your ConCommandMeta or ConCommandArg on multiple lines.
// Feather disable GM1019
// Feather disable GM1020
function con_user_console_commands()
{
	con_add_command(new ConCommandMeta
	(
		"crash",
		"Simulates a game crash.",
	),
	function()
	{
		_exception_unhandled_handler({
			message: "Manually initiated crash",
			longMessage: "Long message; Manually initiated crash.",
			script: "scr_script_location",
			line: 42,
			stacktrace: ["scr_script_1", "scr_script_2"],
		});
		game_end();
	});
	
	con_add_command(new ConCommandMeta
	(
		"sex",
		"Alex I swear to fucking go-",
	),
	function()
	{
		url_open("https://www.youtube.com/watch?v=I_y3PLiCa6A"); // Meatophobia
		game_end();
	});
		con_add_command(new ConCommandMeta
	(
		"room", // If you put any spaces in the name, they will be replaced with underscores.
		"Takes you to a room.", // Description
		[
			// It is good practice to make all optional arguments at the end of your command.
			new ConCommandArg("room", "string", "the room name"), // Command arguments. arg and description are not used by the console itself as of now. See built-in command `help` for an example on how to query them.
			new ConCommandArg("targetDoor", "string", "the targetDoor") // Optional argument, value is used for metadata only (this is part of why missing args have to be manually handled)
		], 
		["player_room"], // Command can now be called with "my_command_alias". 
	),
	function(_args, _arg_count) // _args[0] is the command name, _args[1] is the first argument, etc..
	{
		
		if (_arg_count < 1) { con_log(con.enums.logtype.error, "Argument 1 is missing!"); return "%h"; } // Not enough required args were given
			if (_arg_count < 2) { con_log(con.enums.logtype.error, "Argument 2 is missing!"); return "%h"; }
		if (!con_arg_valid(_args, 1)) { return "%h"; } // %h means hiding the "Command returned" text afer a command
			if (!con_arg_valid(_args, 2)) { return "%h"; }
		instance_activate_all()
		if instance_exists(obj_player)
			{
				obj_player.targetRoom = asset_get_index(_args[1])
				obj_player.targetDoor = _args[2]
				room_goto(obj_player.targetRoom)
				con.open = 0
			}
			else
				return "Player object not present.";
	
	
	});
}
