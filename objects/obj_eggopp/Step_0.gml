/// @description Insert description here
// You can write your code in this editor
if room == room_editor && global.play == 0
   return;
if instance_exists(obj_player)
switch state
{
   case 0:
   if (abs((x - obj_player.x)) > 30)
    image_xscale = sign((obj_player.x - x))
	if !(place_meeting(x, y+vspeed, obj_solid) || place_meeting(x, y+vspeed, obj_platform))
	   vspeed += 1
	else  
	   vspeed = 0
	with obj_eggopp_detectionbox
	{
		if place_meeting(x, y, obj_player) && other.thingy == 0 && target == other.id
		{
			if !collision_line(x, y-5, obj_player.x, obj_player.y-5, obj_solid, false, false)
			{
				other.alarm[0] = 25
				other.thingy = 1
			}
		}
	}
        break
	case 1:
	 if (abs((x - obj_player.x)) > 30)
    image_xscale = sign((obj_player.x - x))
	
	if ds_queue_size(queue) >= queuerandom
	{
		vspeed = 0
		interp = Approach(interp, 1, _speed);
		x = lerp(x, ds_queue_dequeue(queue), interp);
		y = lerp(y, ds_queue_dequeue(queue), interp);
		image_blend = c_white
		if thingy4 == 0
		{
			instance_create(x, y, obj_poofeffect)
			thingy4 = 1
		}
	}
	if ds_queue_size(queue) >= queuerandom - 25 && thingy2 == 0
	{
		alarm[1] = 2
		audio_play_sound(sfx_teleport, 0, 0)
		thingy2 = 1
	}
	if instance_exists(obj_player)
		ds_queue_enqueue(queue, obj_player.x, obj_player.y);
	image_speed = 0.35
	sprite_index = spr_eggopp_move
	if distance_to_object(obj_player) > 750
	{
		state = 0
		sprite_index = spr_eggopp_idle
		thingy = 0
		thingy2 = 0
		thingy3 = 0
		thingy4 = 0
		image_speed = 0.7
		ds_queue_clear(queue);
	}
	break
}
else
    instance_destroy()

