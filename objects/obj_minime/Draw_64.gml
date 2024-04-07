/// @description Insert description here
// You can write your code in this editor
#region bg
if (bg.visible)
{
	if (global.performance)
	{
		// Single sprite for performance mode
		var spr = [bg.spr, bg.index];
		draw_sprite(spr[0], spr[1], 0, 0);
		bg.index++;
		bg.index %= 11;
	}
	else
	{
		var gw = display_get_gui_width();
		var gh = display_get_gui_height(); // GH More like GitHub amirite
		var spr = [bg.spr, bg.index];
		draw_sprite(spr[0], spr[1], bg.x, bg.y);
		draw_sprite(spr[0], spr[1], bg.x - gw, bg.y);
		draw_sprite(spr[0], spr[1], bg.x, bg.y + gh);
		draw_sprite(spr[0], spr[1], bg.x - gw, bg.y + gh);
		bg.x += floor(bg.speed);
		bg.y -= floor(bg.speed); //TODO: FIX Y, commented for now
		if (bg.x >= display_get_gui_width())
			bg.x = 0;
		if (bg.y <= -display_get_gui_height())
			bg.y = 0;
	}
}
draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);
#endregion
draw_set_font(Font2)
switch menu
{
	case 1:
		draw_set_alpha(1)
		distance = 125
		if index == 1
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "BACK")
		distance += distanceamount
		if index == 2
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "LEVEL EDITOR")
		distance += distanceamount
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "LOAD LEVEL")
		/*
		draw_set_color(index == 7 ? c_yellow : c_white);
		draw_text(600, distance, "LOAD ONLINE LEVEL");
		*/
		distance += distanceamount
		
		if index == 4
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "EDITOR GUIDE")
		distance += distanceamount
		if index == 5
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "SETTINGS")
		distance += distanceamount
		if (index == 6)
			draw_set_color(c_yellow);
		else
			draw_set_color(c_white);
		draw_text(300, distance, "CONVERT LEVEL TO NEW FORMAT")
	break
		
	case 2:
		draw_set_alpha(1)
		distance = 125
		if index == 1
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "BACK")
		distance += distanceamount
		draw_set_alpha(0.5)
		if index == 2
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "COOP MODE: " + string(global.coop) + " (COMING IN 2.5)")
		distance += distanceamount
		draw_set_alpha(1)
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "KEY REMAPPING")
		distance += distanceamount
		if index == 4
			draw_set_color(c_yellow);
		else
			draw_set_color(c_white);
		draw_text(300, distance, $"PERFORMANCE MODE: {global.performance ? "ON" : "OFF"}");
		distance += distanceamount;
	break
	
	case 3:
		draw_set_alpha(1)
		distance = 125
		if index == 1
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "BACK")
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
			draw_text(300,distance, "KEYBOARD (UNPLUG CONTROLLER TO REMAP)")
		else
			draw_text(300,distance, "KEYBOARD")
		distance += distanceamount
		draw_set_alpha(0.5)
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "CONTROLLER  (COMING IN 2.5)")
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
		draw_text(300,distance, "BACK")
		distance += distanceamount
		//ini_read_string("keybinds", "key_left", "vk_left")
		
		ini_open("keybinds.ini")
		
		if index == 2
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "LEFT   " + ini_read_string("keybinds", "key_left", "vk_left"))
		distance += distanceamount
		
		if index == 3
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "RIGHT   " + ini_read_string("keybinds", "key_right", "vk_right"))
		distance += distanceamount
		
		if index == 4
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "UP   " + ini_read_string("keybinds", "key_up", "vk_up"))
		distance += distanceamount
		
		if index == 5
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "DOWN  " + ini_read_string("keybinds", "key_down", "vk_down"))
		distance += distanceamount
		
		if index == 6
			draw_set_color(c_yellow)
		else
			draw_set_color(c_white)
		draw_text(300,distance, "JUMP  " + ini_read_string("keybinds", "key_jump", "Z"))
		distance += distanceamount
		
		ini_close()
	break
}


//draw_text(x, y, controllerdown)

draw_set_color(c_white)