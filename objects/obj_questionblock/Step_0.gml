if place_meeting(x, bbox_bottom ,obj_player ) && hit = 0 && delay = 0
	{
		hit = 1
		wait = 32
		delay = 32
		audio_play_sound(sfx_punch, 0, 0)
		with instance_create(x, y-70, obj_goomba)
		   insideView = 1
	}
	
if hit == 1
	{
		if wait > 0
		   wait -= spd
		else
		   wait = 0
	}
if delay > 0
		   delay -= 1
		else
		   delay = 0