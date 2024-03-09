#macro DEBUG (GM_build_type == "run")
#macro CRASH_SHOW_MESSAGEBOX DEBUG // If you wanna make release builds show the crash as a message box then set this to true

global.saveroom = ds_list_create();
global.instancelist = ds_list_create();
global.collect = 0;
global.debuglog = [];
ini_open("settings.ini");
global.performance = ini_read_real("Settings", "performance", false);
ini_close();
// Game ver is now obj_gmconsole.con.strings.game_version
// NOTE: 0.03.00.00 removed obj_gmconsole.con.strings.game_version
global.game_version = "2.25";


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
	if instance_number(obj_gmconsole) >= 1
	{
		var _conout = obj_gmconsole.con.output
		var _console_output = "";
		for (var i = 0; i < ds_list_size(_conout); i++)
		{
			var _add =  _conout[| i];
			_console_output += $"{_add}\n";
			
		}
		_console_output += "---";
		file_text_write_string(_f, $"{_console_output}\n");
	}
	file_text_write_string(_f, "---");
	/*for (var i = 0; i < array_length(global.debuglog); i++)
	{
		var _v = global.debuglog[i];
		file_text_write_string(_f, _v);
		file_text_writeln(_f);
	};*/
	file_text_write_string(_f, dump_debug_logs());
	//file_text_write_string(_f, $"{string(_e)}\nNSB {instance_number(obj_gmconsole) >= 1 ? obj_gmconsole.con.strings.game_version : "N/A"}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{(is_debug() ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
	file_text_write_string(_f, $"{string(_e)}\nNSB {global.game_version}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{compile_type_tostring(get_compile_type())}");
	file_text_close(_f);
	if (CRASH_SHOW_MESSAGEBOX)
	{
		//show_message($"EXCEPTION!\n----------\n{_e.message}\n{_e.stacktrace}\n{(is_debug() ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
		show_message($"EXCEPTION!\n----------\n{_e.message}\n{_e.stacktrace}\n{compile_type_tostring(get_compile_type())}");
	}
}

exception_unhandled_handler(_exception_unhandled_handler);

/// @returns {String}
/// @self undefined
/// @pure
function dump_debug_logs()
{
	var _ret = "";
	for (var i = 0; i < array_length(global.debuglog); i++)
	{
		_ret += $"{global.debuglog[i]}\n---\n";
	}
	return _ret;
}