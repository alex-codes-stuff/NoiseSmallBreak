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
if index >= 6.1
    index = 1
if index <= 0.9
    index = 1
	
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
		break
		case 2:
		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = room_editor
		   break
	case 3:
	global.filename = get_open_filename_ext(".sav", "", game_save_id, "Select level file (.sav)");
 

		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = room_customlevel
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
	}
		break
	}
	
	
}

