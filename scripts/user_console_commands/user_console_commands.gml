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
}
// See wiki for info on how to add commands