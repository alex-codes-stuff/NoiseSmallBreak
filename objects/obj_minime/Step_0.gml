/// @description Insert description here
// You can write your code in this editor



switch menu
{
	case 1:
if keyboard_check_pressed(vk_down) 
{
   index += 1
   audio_play_sound(sfx_select2, 0 ,0)
}


if keyboard_check_pressed(vk_up) 
{
   index += -1
    audio_play_sound(sfx_select2, 0 ,0)
}
if index >= 5.1
    index = 1
if index <= 0.9
    index = 1
break 
case 2:
     	
if keyboard_check_pressed(vk_down) 
{
   index += 1
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up)
{
   index += -1
    audio_play_sound(sfx_select2, 0 ,0)
}
if index >= 3.1
    index = 1
if index <= 0.9
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
break

 case 3:
 if keyboard_check_pressed(vk_down) 
{
   index += 1
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up) 
{
   index += -1
    audio_play_sound(sfx_select2, 0 ,0)
}
if index >= 3.1
    index = 1
 break
 case 4:
 if setkey == 0
 {
 if keyboard_check_pressed(vk_down) 
{
   index += 1
   audio_play_sound(sfx_select2, 0 ,0)
}
if keyboard_check_pressed(vk_up) 
{
   index += -1
    audio_play_sound(sfx_select2, 0 ,0)
}
 }
if index >= 6.1
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
if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))
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
	global.filename = get_open_filename_ext(".sav", "", game_save_id, "Select level file (.sav)");
 
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
			   menu = 4
			   index = 1
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


