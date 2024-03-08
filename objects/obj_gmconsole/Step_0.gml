/// @description Open console and execute commands
if keyboard_check_pressed(vk_f5)
	if (con.open) { keyboard_string = con.previous_keyboard_string; con_close(); } 
	else { con.previous_keyboard_string = keyboard_string; con_open(); keyboard_string = ""; }

if (con.open)
{
	if (keyboard_check_pressed(vk_tab))
	{
		keyboard_string += "    ";
	}
	if (keyboard_check_pressed(vk_enter) && string_replace_all(keyboard_string, " ", "") != "")
	{
		while (string_char_at(keyboard_string, 1) == " ")
		{
			keyboard_string = string_copy(keyboard_string, 2, string_length(keyboard_string));
		}
		con_call_command(string_split(keyboard_string, " "));
		keyboard_string = ""
	}
	// Feather disable once GM2016
	_cmdargs = undefined;
	
	if (keyboard_check_pressed(vk_anykey)) // Konami code easter egg (not so secret now that you're seeing it, is it?)
	{
		var _check = vk_nokey;
		switch (con.easteregg.konami)
		{
			case 0:
			case 1:
				_check = vk_up;
			break;
			case 2:
			case 3:
				_check = vk_down;
			break;
			case 4: // Left (Right)
			case 6: // Left (Right) 2
				_check = vk_left;
			break;
			case 5: // (Left) Right
			case 7: // (Left) Right 2
				_check = vk_right;
			break;
			case 8:
				_check = ord("B");
			break;
			case 9:
				_check = ord("A");
			break;
			default:
				con.easteregg.konami = 0; // Reset
			break;
		}
    

		if (keyboard_check_pressed(_check))
		{
			con.easteregg.konami++;
		} else
		{
			con.easteregg.konami = 0;
		}


		if (con.easteregg.konami == 10)
		{
			instance_destroy(self); // Sorry anyone that expected something cool
		}
	}
}