/// @description Insert description here
// You can write your code in this editor
controllerdown = false;
controllerup = false;
controllera = false;
if delaydown > 0
   delaydown--
if delayup > 0
   delayup--
if delayright > 0
   delayright--
if delayleft > 0
   delayleft--
   
if gamepad_axis_value(0, gp_axislv) > 0.9 && delaydown == 0
{
	delaydown = 10;
	controllerdown = true;
}
if gamepad_axis_value(0, gp_axislv) < -0.9 && delayup == 0
{
	delayup = 10;
	controllerup = true;
}
if (gamepad_button_check_pressed(0, gp_face1))
{
	controllera = true;
}
switch menu
{
	case 1:
if keyboard_check_pressed(vk_down) || controllerdown
{
   index++
   audio_play_sound(sfx_select2, 0 ,0)
}


if keyboard_check_pressed(vk_up)   || controllerup
{
   index--
    audio_play_sound(sfx_select2, 0 ,0)
}
if index > 7
    index = 1
if index < 1
    index = 7
	
if ((keyboard_check_pressed(vk_right) || controllerright) && index != 7)
{
	index = 7;
}

if ((keyboard_check_pressed(vk_left) || controllerleft) && index == 7)
{
	index = 3;
}

break 
case 2:
     	
if keyboard_check_pressed(vk_down) || controllerdown
{
   index++
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up) || controllerup
{
   index--
    audio_play_sound(sfx_select2, 0 ,0)
}
if index > 4
    index = 1
if index < 1
    index = 1
	//coop
	/*
if index == 2 && keyboard_check_pressed(vk_right)
{
   global.coop = 1
    audio_play_sound(sfx_select2, 0 ,0)
}
if index == 2 && keyboard_check_pressed(vk_left)
{
   global.coop = 0
    audio_play_sound(sfx_select2, 0 ,0)
}
*/
if (index == 4 && ((keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) || controllera))
{
	global.performance = !global.performance;
	ini_open("settings.ini");
	// Feather disable once GM1041 YOU FUCKING SUCK FEATHER HOLY SHIT
	ini_write_real("Settings", "performance", global.performance);
	ini_close();
}
break

 case 3:
 if keyboard_check_pressed(vk_down)|| controllerdown
{
   index++;
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up)  || controllerup
{
   index--;
    audio_play_sound(sfx_select2, 0 ,0)
}
if index > 3
    index = 1
 break
 case 4:
 if setkey == 0
 {
 if keyboard_check_pressed(vk_down) || controllerdown
{
   index++
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up)  || controllerup
{
   index--
    audio_play_sound(sfx_select2, 0 ,0)
}
 }
if index > 6
    index = 1
if keyboard_check_pressed(vk_anykey) && setkey == 1
{
	if index == 2
	{
		ini_open("keybinds.ini")
	var check = global.keys[? scr_keyboard_key_name(keyboard_lastkey)]
	if !is_undefined(check)
		ini_write_string("keybinds", "key_left", scr_keyboard_key_name(keyboard_lastkey))
	else
	   ini_write_string("keybinds", "key_left",scr_keyboard_key_name(keyboard_lastkey))
	ini_close()
	}
	if index == 3
	{
			ini_open("keybinds.ini")
	var check = global.keys[? scr_keyboard_key_name(keyboard_lastkey)]
	if !is_undefined(check)
		ini_write_string("keybinds", "key_right", scr_keyboard_key_name(keyboard_lastkey))
	else
	   ini_write_string("keybinds", "key_right",scr_keyboard_key_name(keyboard_lastkey))
	ini_close()
	}
	if index == 4
	{
			ini_open("keybinds.ini")
	var check = global.keys[? scr_keyboard_key_name(keyboard_lastkey)]
	if !is_undefined(check)
		ini_write_string("keybinds", "key_up", scr_keyboard_key_name(keyboard_lastkey))
	else
	   ini_write_string("keybinds", "key_up",scr_keyboard_key_name(keyboard_lastkey))
	ini_close()
	}
	if index == 5
	{
			ini_open("keybinds.ini")
	var check = global.keys[? scr_keyboard_key_name(keyboard_lastkey)]
	if !is_undefined(check)
		ini_write_string("keybinds", "key_down", scr_keyboard_key_name(keyboard_lastkey))
	else
	   ini_write_string("keybinds", "key_down",scr_keyboard_key_name(keyboard_lastkey))
	ini_close()
	}
		if index == 6
	{
			ini_open("keybinds.ini")
	var check = global.keys[? scr_keyboard_key_name(keyboard_lastkey)]
	if !is_undefined(check)
		ini_write_string("keybinds", "key_jump", scr_keyboard_key_name(keyboard_lastkey))
	else
	   ini_write_string("keybinds", "key_jump",scr_keyboard_key_name(keyboard_lastkey))
	ini_close()
	}
	setkey = 0
}
if keyboard_check_pressed(vk_enter) && setkey == 0
{
	setkey = 1
	
}
 break
}
if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1)
{
	
	switch menu
	{
		case 1:
		
	switch index	
	{
		case 1:
		
		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = hub_1
		audio_stop_all()
		break
		case 2:
		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = room_editor
		   	audio_stop_all()
		   break
	case 3:
	global.filename = get_open_filename_ext(".bblv", "", game_save_id, "Select level file (.bblv)");
 
    if global.filename != noone
	{
		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = room_customlevel
		 	audio_stop_all()
	}
	else
	   global.filename = ""
		   break
    case 4:
		url_open("https://docs.google.com/document/d/1D2BOrYJPYx0sE8uyUBOX8kDAFDcvoZg4rEiF2YgioUM/edit?usp=sharing")
		   break
    case 5:
		menu = 2
		index = 1
		   break  
		   
	case 6:
		try
		{
			var _file = get_open_filename_ext("Old level format (.sav)|*.sav", "", game_save_id, "Select old level (.sav)");
			var _file_oldfmt = scr_jsonthing(_file);
			var wrapper = {};
			var _root = _file_oldfmt[? "root"];
			wrapper.root = [];
			for (var i = 0; i < ds_list_size(_root); i++)
			{
				wrapper.root[i] = _root[| i];
			}
			var _room = _file_oldfmt[? "room"];
			wrapper.room = {};
			var _values = ["room_width", "room_height", "background_tint", "song"];
			for (var i = 0; i < array_length(_values); i++)
			{
				var _index = _values[i];
				wrapper.room[$ _index] = _room[? _index];
			}
			var _outfile = get_save_filename_ext("New level format (.bblv)|*.bblv", "", game_save_id, "New level (.bblv)");
			var _buff = scr_editor_encrypt(wrapper);
			buffer_save(_buff, _outfile);
			buffer_delete(_buff);
		}
		catch (_e)
		{
			show_debug_message($"Exception converting old level format: {string(_e)}");
			show_message($"Couldn't convert level: {_e.message}.\nAn extended report will be available in the debug log.");
		}
	break;
	
	case 7:
		room_goto(room_upload); //TODO: Make this
	break;
   
	}
	break
	case 2:
	switch index{
		
		case 1:
		    menu = 1
			index = 5
			break
		case 3:
		    menu = 3
			index = 1
			break
			
	}
		break
	case 3:
	    switch index{
			case 1:
			     menu = 2
			index = 3
			break
			case 2:
			if !gamepad_is_connected(0)
			{
			   menu = 4
			   index = 1
			}
			   break
			   //controller remap
			   /*
			case 3:
			   menu = 5
			   index = 1
			   break
			   */
			
			
		}
			break
			
		case 4:
		switch index{
			case 1:
			    menu = 3
				index = 2
				setkey = 0
			break
		}
			break
		
	
	}
	
	
}


