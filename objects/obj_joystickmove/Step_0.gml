var held = 0
var base = obj_joystick_base
if device_mouse_check_button(0, mb_left) && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), base.x-(base.sprite_width + 30), base.y-(base.sprite_height+30), base.x+(base.sprite_width + 30), base.y+(base.sprite_height+30))
{
	//stolen code :yum:
	    joy_x = device_mouse_x_to_gui(0) - obj_joystick_base.x;
        joy_y = device_mouse_y_to_gui(0) - obj_joystick_base.y;
       held = 1
        var _direction = point_direction(0, 0, joy_x, joy_y);
        var _distance = point_distance(0, 0, joy_x, joy_y);
		distance = _distance
        var radius = obj_joystick_base.sprite_width/2
		
        if (_distance > radius)
                {
                        joy_x = lengthdir_x(radius, _direction);
                        joy_y = lengthdir_y(radius, _direction);
                }
					
		x = obj_joystick_base.x + joy_x
		y = obj_joystick_base.y + joy_y
}
else
{
	held = 0
	 x = xx
	 y = yy
}
if place_meeting(x, y, obj_joystick_right)
    obj_player.key_right = 1



