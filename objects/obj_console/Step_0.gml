if keyboard_check_pressed(vk_f5)
	if (con.open) { keyboard_string = con.previous_keyboard_string; con_close(); } 
	else { con.previous_keyboard_string = keyboard_string; con_open(); keyboard_string = ""; }

if (con.open)
{
	if (keyboard_check_pressed(vk_enter) && keyboard_string != "")
	{
		try
		{
			var _cur_output_size = ds_list_size(con.output) + 1;
			con_log(con.enums.logtype.none, $">{keyboard_string}");
			var args = string_split(keyboard_string, " ");
			var _ret = struct_get(con.commands, args[0])(args);
			if _cur_output_size == ds_list_size(con.output) { con_log(con.enums.logtype.log, "Command did not print anything"); }
			// Feather disable once GM1100
			con_log(con.enums.logtype.log, $"Command returned {(string_pos(typeof(_ret), "string|number|int32|int64|bool") != 0 ? $"{typeof(_ret)}: {string(_ret)}" : typeof(_ret))}");
		}
		catch (e)
		{
			var _invalid_cmd = e.message == "Invalid callv target #2"
			con_log(con.enums.logtype.err, $"Couldn't execute command: {_invalid_cmd ? "Invalid command. You can see a list of commands with `cmds`" : $"{e.message} @ {e.script}"}");
		}
		keyboard_string = ""
	}
}