#macro DEBUG (GM_build_type == "run")
#macro CRASH_SHOW_MESSAGEBOX DEBUG // If you wanna make release builds show the crash as a message box then set this to true

global.saveroom = ds_list_create();
global.instancelist = ds_list_create();
global.collect = 0;
// Game ver is now obj_console.con.strings.game_version


// Custom exception handler
function _exception_unhandled_handler(_e)
{
	__show_debug_message_base("EXCEPTION!");
	__show_debug_message_base("----------");
	__show_debug_message_base(_e.message);
	__show_debug_message_base(_e.stacktrace);
	var _file_name = working_directory + $"crash-{date_current_datetime()}.txt";
	__show_debug_message_base($"Attempting to write crash to file at {_file_name}.");
	if file_exists(_file_name) { file_delete(_file_name) }
	var _f = file_text_open_write(_file_name);
	if instance_exists(obj_console)
	{
		var _conout = obj_console.con.output
		var _console_output = "";
		for (var i = 0; i < ds_list_size(_conout); i++)
		{
			var _add =  _conout[| i];
			// Exclude date from console output because it's bugged out(?)
			/*_add[1] = _add[2];
			array_pop(_add);*/
			_console_output += $"{_add}\n";
			
		}
		_console_output += "---";
		file_text_write_string(_f, $"{_console_output}\n");
	}
	file_text_write_string(_f, $"{string(_e)}\nNSB {global.gamever}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{(DEBUG ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
	file_text_close(_f);
	if (CRASH_SHOW_MESSAGEBOX)
	{
		show_message($"EXCEPTION!\n----------\n{_e.message}\n{_e.stacktrace}\n{(DEBUG ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
	}
}

exception_unhandled_handler(_exception_unhandled_handler);