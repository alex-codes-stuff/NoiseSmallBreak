// Overwrite show_debug_message
#macro __show_debug_message_base show_debug_message
#macro show_debug_message __show_debug_message_overwrite
function __show_debug_message_overwrite(str)
{
	var _ret = str;
	for (var i = 0; i < argument_count - 1; i++)
	{
		_ret = string_replace_all(_ret, $"\{{i}\}", string(argument[i+1]));
	}
	if (instance_exists(obj_console))
	{
		with (obj_console) { con_log(obj_console.con.enums.logtype.debug, _ret); }
	}
	
	__show_debug_message_base(str);
}