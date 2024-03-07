#macro DEBUG (GM_build_type == "run")
#macro CRASH_SHOW_MESSAGEBOX DEBUG // If you wanna make release builds show the crash as a message box then set this to true

global.saveroom = ds_list_create();
global.instancelist = ds_list_create();
global.collect = 0;
global.debuglog = [];
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
	if instance_number(obj_console) >= 1
	{
		var _conout = obj_console.con.output
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
	//file_text_write_string(_f, $"{string(_e)}\nNSB {instance_number(obj_console) >= 1 ? obj_console.con.strings.game_version : "N/A"}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{(is_debug() ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
	file_text_write_string(_f, $"{string(_e)}\nNSB {instance_number(obj_console) >= 1 ? obj_console.con.strings.game_version : "dont fuckin know"}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{compile_type_tostring(get_compile_type())}");
	file_text_close(_f);
	if (CRASH_SHOW_MESSAGEBOX)
	{
		//show_message($"EXCEPTION!\n----------\n{_e.message}\n{_e.stacktrace}\n{(is_debug() ? "TEST BUILD" : (code_is_compiled() ? "COMPILED/YYC BUILD" : "RELEASE/VM BUILD"))}");
		show_message($"EXCEPTION!\n----------\n{_e.message}\n{_e.stacktrace}\n{compile_type_tostring(get_compile_type())}");
	}
}

exception_unhandled_handler(_exception_unhandled_handler);

/// @pure
/// @returns {Bool}
function is_debug()
{
	return instance_number(obj_console) >= 1 ? !obj_console.con.build.release : DEBUG;
}

/// @description 1 = test, 2 = release (vm), 3 = compiled (yyc)
/// @returns {Real}
/// @self undefined
/// @pure
function get_compile_type()
{
	return (is_debug ? 1 : (code_is_compiled ? 3 : 2))
}

/// @param {Real} in
/// @returns {String}
/// @self undefined
/// @pure
function compile_type_tostring(in)
{
	var _compile_type = "";
	switch (get_compile_type())
	{
		case 1:
			_compile_type = "TEST BUILD";
		break;
		case 2:
			_compile_type = "RELEASE/VM BUILD";
		break;
		case 3:
			_compile_type = "COMPILED/YYC BUILD";
		break;
		default:
			_compile_type = "how did you mess up so badly gm doesnt even know if this is a release build";
		break;
	}
	return _compile_type;
}

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