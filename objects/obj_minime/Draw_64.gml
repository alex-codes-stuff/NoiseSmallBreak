/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white)
draw_sprite(pauseScreenshot, 0, 0, 0)
draw_set_color(c_black)
#region bg
if (bg.visible)
{
	if (global.performance)
	{
		// Single sprite for performance mode
		var spr = [bg.spr, bg.index];
		draw_sprite_ext(spr[0], spr[1], 0, 0, 1, 1, 90, c_white, image_alpha);
		bg.index++;
		bg.index %= 11;
	}
	else
	{
		var gw = display_get_gui_width();
		var gh = display_get_gui_height(); // GH More like GitHub amirite
		var spr = [bg.spr, bg.index];
		draw_sprite_ext(spr[0], spr[1], bg.x, bg.y, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x - gw, bg.y, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x, bg.y + gh, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x - gw, bg.y + gh, 1, 1, 90, c_white, image_alpha);
		bg.x += floor(bg.speed);
		bg.y -= floor(bg.speed); //TODO: FIX Y, commented for now
		if (bg.x >= display_get_gui_width())
			bg.x = 0;
		if (bg.y <= -display_get_gui_height())
			bg.y = 0;
	}
}

draw_set_alpha(0.75);
draw_sprite_stretched_ext(spr_BLACK, 0, 0, 0, display_get_gui_width(), display_get_gui_height(), c_white, _alpha);
draw_set_color(c_white);
draw_set_alpha(1);
#endregion
draw_set_font(fnt_console_big)
var _menuitems = 0
var _menuitemnames = [""]
switch menu
{
	case 1:
	    _menuitems = 6
		_menuitemnames = ["BACK", "LEVEL EDITOR", "LOAD LEVEL", "EDITOR GUIDE", "SETTINGS", "EXIT"]
		distance = 125
		draw_set_alpha(1)
		for (var i = 1; i < (_menuitems+1); i += 1)
		{
			if (index == i)
				draw_set_color(c_yellow)
			else
				draw_set_color(c_white)
			draw_text(_x,distance, array_get(_menuitemnames, i-1))
			distance += distanceamount
		}
		
		
	break
		
	case 2:
		_menuitems = 5
		_menuitemnames = ["BACK", ("COOP MODE: " + string(global.coop)), "KEY REMAPPING",  $"PERFORMANCE MODE: {global.performance ? "ON" : "OFF"}", ("FULLSCREEN: " + string(global.fullscreen))]
		distance = 125
		draw_set_alpha(1)
		for (var i = 1; i < (_menuitems+1); i += 1)
		{
			if (index == i)
				draw_set_color(c_yellow)
			else
				draw_set_color(c_white)
			if i == 2
			  draw_set_alpha(0.5)
			draw_text(_x,distance, array_get(_menuitemnames, i-1))
			draw_set_alpha(1)
			distance += distanceamount
		}
		
	break
	
	case 3:
		draw_set_alpha(1)
		distance = 125
		if index == 1
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "BACK")
		distance += distanceamount
		if gamepad_is_connected(0)
			draw_set_alpha(0.5)
		else
			draw_set_alpha(1)
		if index == 2
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		if gamepad_is_connected(0)
			draw_text(_x,distance, "KEYBOARD (UNPLUG CONTROLLER TO REMAP)")
		else
			draw_text(_x,distance, "KEYBOARD")
		distance += distanceamount
		draw_set_alpha(0.5)
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "CONTROLLER (UNFINISHED)")
		distance += distanceamount
		draw_set_alpha(1)
	break
	
	case 4:
		draw_set_alpha(1)
		distance = 125
		if index == 1
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "BACK")
		distance += distanceamount
		//ini_read_string("keybinds", "key_left", "vk_left")
		
		ini_open("keybinds.ini")
		
		if index == 2
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "LEFT   " + ini_read_string("keybinds", "key_left", "vk_left"))
		distance += distanceamount
		
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "RIGHT   " + ini_read_string("keybinds", "key_right", "vk_right"))
		distance += distanceamount
		
		if index == 4
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "UP   " + ini_read_string("keybinds", "key_up", "vk_up"))
		distance += distanceamount
		
		if index == 5
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "DOWN  " + ini_read_string("keybinds", "key_down", "vk_down"))
		distance += distanceamount
		
		if index == 6
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(_x,distance, "JUMP  " + ini_read_string("keybinds", "key_jump", "Z"))
		distance += distanceamount
		
		ini_close()
	break
}


//draw_text(x, y, controllerdown)

draw_set_color(c_white)