if global.play != 0
{
if !place_meeting(x, y + 1, obj_player)
	grounded = false;
else if !grounded
	instance_destroy();
}