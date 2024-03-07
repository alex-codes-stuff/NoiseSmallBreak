/// @description Dump debug logs
var _file_location = $"{working_directory}debug.log"
if file_exists(_file_location) { file_delete(_file_location) }
var _f = file_text_open_write(_file_location);
file_text_write_string(_f, dump_debug_logs());
file_text_writeln(_f);
file_text_write_string(_f, $"NSB {instance_number(obj_console) >= 1 ? obj_console.con.strings.game_version : "dont fuckin know"}; GameMaker {GM_runtime_version}; Build Date {date_datetime_string(GM_build_date)}\n{compile_type_tostring(get_compile_type())}");
file_text_close(_f);