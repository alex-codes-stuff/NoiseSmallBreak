while keyboard_check_pressed(vk_up) || (gamepad_axis_value(0, gp_axislv) < -0.5)
with other
{
	targetRoom = other.targetRoom;
	targetDoor = other.targetDoor;
	
	x = lerp(other.bbox_left, other.bbox_right, 0.5);
	
	if !instance_exists(obj_fadeout)
		instance_create(0, 0, obj_fadeout);
}
