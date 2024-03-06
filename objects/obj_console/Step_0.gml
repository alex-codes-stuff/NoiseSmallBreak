/// @description Open console and execute commands
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
			// Feather disable once GM2016
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
			var _ret = con.commands.data[$ _cmdargs[0]].func(_cmdargs);
			if _cur_output_size == ds_list_size(con.output) { con_log(con.enums.logtype.log, $"{con.strings.cmdbar.no_print}"); }
			// Feather disable once GM1100
			// Feather disable once GM1063
			// Feather disable once GM1012
			con_log(con.enums.logtype.log, $"{con.strings.cmdbar.returned} {(string_pos(typeof(_ret), "string|number|int32|int64|bool|struct|array") != 0 ? $"{con.strings.cmdbar.types[$ typeof(_ret)]}: {string(_ret)}" : (typeof(_ret) == "undefined" ? con.strings.cmdbar.types.undefined : typeof(_ret)))}"); // Woah this line is atrociously long
		}
		catch (e)
		{
			var _invalid_cmd = string_ends_with(e.message, "cannot be resolved.");
			// Feather disable once GM1063
			// Feather disable once GM1100
			con_log(con.enums.logtype.err, $"{con.strings.cmdbar.couldnt_exec} {_invalid_cmd ? $"{con.strings.cmdbar.invalid} {con.strings.cmdbar.invalid_cmds}" : $"{e.message} @ {e.script} {con.strings.cmdbar.line} {e.line}"}");
		}
		keyboard_string = ""
	}
	// Feather disable once GM2016
	_cmdargs = undefined;
}