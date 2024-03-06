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
			_cmdargs = string_split(string_lower(keyboard_string), " "); // Defining this as a temp object variable so we can use it in struct_foreach
			//var _ret = struct_get(con.commands, _args[0])(_args);
			struct_foreach(con.commands.aliases, function(_key, _value)
			{
				//show_message($"{_cmdargs[0]} = {_key}");
				if (string_lower(_cmdargs[0]) == string_lower(_key))
				{
					_cmdargs[0] = string_lower(_value);
				}
			});
			var _args = _cmdargs;
			_cmdargs = undefined; // Undefine _cmdargs as _args replaces it
			var _ret = con.commands.data[$ _args[0]].func(_args);
			if _cur_output_size == ds_list_size(con.output) { con_log(con.enums.logtype.log, "Command did not print anything"); }
			// Feather disable once GM1100
			con_log(con.enums.logtype.log, $"Command returned {(string_pos(typeof(_ret), "string|number|int32|int64|bool") != 0 ? $"{typeof(_ret)}: {string(_ret)}" : typeof(_ret))}");
		}
		catch (e)
		{
			var _invalid_cmd = string_ends_with(e.message, "cannot be resolved.");
			con_log(con.enums.logtype.err, $"Couldn't execute command: {_invalid_cmd ? "Invalid command. You can see a list of commands with `cmds`" : $"{e.message} @ {e.script} line {e.line}"}");
		}
		keyboard_string = ""
	}
}