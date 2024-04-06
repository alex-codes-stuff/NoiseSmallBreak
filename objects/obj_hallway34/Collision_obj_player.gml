if obj_player.key_up && obj_player.grounded && obj_player.state = states.normal && !(targetRoom == room_minimenu && os_type == os_android)
with other
{
	if room == moonlight_4
	{
	   timerend = 1
	   ds_list_clear(global.saveroom);
	}
	sprite_index = spr_player_idle
	targetRoom = other.targetRoom;
	targetDoor = other.targetDoor;
	
	x = lerp(other.bbox_left, other.bbox_right, 0.5);
	
	if !instance_exists(obj_fadeout)
		instance_create(0, 0, obj_fadeout);
}
