/// @description Insert description here
// You can write your code in this editor
with obj_eggopp_detectionbox
	{
		if place_meeting(x, y, obj_player) && target == other.id
		{
			if !collision_line(x, y-5, obj_player.x, obj_player.y-5, obj_solid, false, false)
			{
				other.state = 1
				
			}
			else
				other.about_to_detect = 0
		}
		else
			 other.about_to_detect = 0
}
thingy = 0

