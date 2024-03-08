// Overwrite show_debug_message
#macro __show_debug_message_base show_debug_message
#macro show_debug_message __show_debug_message_overwrite
/// @param {String}	str
/// @param {Any} argument
function __show_debug_message_overwrite(str)
{
	var _ret = str;
	for (var i = 0; i < argument_count - 1; i++)
	{
		_ret = string_replace_all(_ret, $"\{{i}\}", string(argument[i+1]));
	}
	if (instance_number(obj_gmconsole) >= 1)
	{
		with (obj_gmconsole) { con_log(con.enums.logtype.debug, _ret); }
	}
	if (variable_global_exists("debuglog"))
	{
		array_push(global.debuglog, $"show_debug_message: {_ret}");
	}
	
	return __show_debug_message_base(str);
}

// Overwrite show_message
#macro __show_message_base show_message
#macro show_message __show_message_overwrite
/// @param {String} str
function __show_message_overwrite(str)
{
	__show_debug_message_base($"Message box: {str}\n---");
	if (instance_number(obj_gmconsole) >= 1)
	{
		with (obj_gmconsole) { con_log(con.enums.logtype.debug, str); }
	}
	if (variable_global_exists("debuglog"))
	{
		array_push(global.debuglog, $"show_message: {str}");
	}
	
	return __show_message_base(str);
}

// Overwrite get_open_filename and get_save_filename
#macro __get_open_filename_base get_open_filename
#macro __get_open_filename_ext_base get_open_filename_ext
#macro get_open_filename __get_open_filename_overwrite
#macro get_open_filename_ext __get_open_filename_overwrite
/// @param {String} filter
/// @param {String} fname
/// @param {String} directory
/// @param {String} caption
/// @returns {String}
function __get_open_filename_overwrite(filter, fname, directory = undefined, caption = undefined)
{
	__show_debug_message_base($"Get open filename: filter \"{filter}\" fname \"{fname}\"");
	if (instance_number(obj_gmconsole) >= 1)
	{
		with (obj_gmconsole) { con_log(con.enums.logtype.debug, $"get_open_filename: filter \"{filter}\" fname \"{fname}\""); }
	}
	if (variable_global_exists("debuglog"))
	{
		array_push(global.debuglog, $"get_open_filename: filter \"{filter}\" fname \"{fname}\"");
	}
	
	if (argument_count <= 2) { return __get_open_filename_base(filter, fname); } 
	else { return __get_open_filename_ext_base(filter, fname, directory, caption) }
}

#macro __get_save_filename_base get_save_filename
#macro __get_save_filename_ext_base get_save_filename_ext
#macro get_save_filename __get_save_filename_overwrite
#macro get_save_filename_ext __get_save_filename_overwrite
/// @param {String} filter
/// @param {String} fname
/// @param {String} directory
/// @param {String} caption
/// @returns {String}
function __get_save_filename_overwrite(filter, fname, directory = undefined, caption = undefined)
{
	__show_debug_message_base($"Get save filename{argument_count > 2 ? " ext" : ""}: filter \"{filter}\" fname \"{fname}\"");
	if (instance_number(obj_gmconsole) >= 1)
	{
		with (obj_gmconsole) { con_log(con.enums.logtype.debug, $"get_save_filename{argument_count > 2 ? "_ext" : ""}: filter \"{filter}\" fname \"{fname}\""); }
	}
	if (variable_global_exists("debuglog"))
	{
		array_push(global.debuglog, $"get_save_filename{argument_count > 2 ? "_ext" : ""}: filter \"{filter}\" fname \"{fname}\"");
	}
	if (argument_count <= 2) { return __get_save_filename_base(filter, fname); } 
	else { return __get_save_filename_ext_base(filter, fname, directory, caption); }
}