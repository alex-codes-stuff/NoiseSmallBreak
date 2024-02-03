/// @description Insert description here
// You can write your code in this editor
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
	if distance_to_object(obj_player) <250 && thingy == 0
	{
	   alarm[0] = 25 
	   thingy = 1
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
	}
	if instance_exists(obj_player)
		ds_queue_enqueue(queue, obj_player.x, obj_player.y);
	image_speed = 0.35
	sprite_index = spr_eggopp_move
	break
}
else
    instance_destroy()

