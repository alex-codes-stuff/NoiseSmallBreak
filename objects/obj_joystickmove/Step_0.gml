

if device_mouse_check_button(0, mb_left)
{
	//stolen code :yum:
	    joy_x = device_mouse_x_to_gui(0) - obj_joystick_base.x;
        joy_y = device_mouse_y_to_gui(0) - obj_joystick_base.y;
        
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
	 x = 224
	 y = 512
}
if place_meeting(x, y, obj_joystick_right)
    obj_player.key_right = 1



