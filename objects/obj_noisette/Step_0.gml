if global.coop = 0
{
if state == 0
{
	if ds_queue_size(queue) >= 80
	{
		interp = Approach(interp, 1, 0.01);
		x = lerp(x, ds_queue_dequeue(queue), interp);
		y = lerp(y, ds_queue_dequeue(queue), interp);
	}
	/*
	if ds_queue_size(vspqueue) >= 80
	{
		interp2 = Approach(interp2, 1, 0.01);
		vsp = ds_queue_dequeue(vspqueue)
	}
	*/
	if instance_exists(obj_player)
	{
		ds_queue_enqueue(queue, obj_player.x, obj_player.y);
		//ds_queue_enqueue(vspqueue, obj_player.vsp);
	}
    
}
else
{
	interp = 0;
	interp2 = 0;
	ds_queue_clear(queue);
	ds_queue_clear(vspqueue);
}

// helping points
var point = noone;
if instance_exists(obj_player)
{
with obj_player
{
	with instance_nearest(x, y, obj_noisette_point)
	{
		if distance_to_object(other) < SCREEN_WIDTH / 3
			point = id;
	}
}
}
if instance_exists(point)
{
	state = 1;
	x = lerp(x, point.x, 0.1);
	y = lerp(y, point.y, 0.1);
	
	if distance_to_object(point) < 50
	{
		x = point.x;
		y = point.y;
	}
}
else
	state = 0;
grounded = scr_solid(x, y + 10);
// sprite
if helicoptertime > 0
  helicoptertime--
if particletime > 0
  particletime--
if x != xprevious or y != yprevious
{
	if helicopter == 0
	{
		sprite_index = spr_noisette_move;
	}
	else
	{
		if sprite_index != spr_noisette_helistart && sprite_index != spr_noisette_heli
		{
			sprite_index = spr_noisette_helistart
			image_index = 0
		}
		if sprite_index == spr_noisette_helistart && image_index >= image_number - 1
		{
		    sprite_index = spr_noisette_heli
			image_index = 0
		}
	}
	if grounded
	{
		if helicopter == 1
		{
			sound_play_3d(sfx_land, x, y);
		}
	   helicopter = 0
	   
	}
}

else
{
	sprite_index = spr_noisette_idle;
	helicopter = 0
	helicoptertime = 0
}

if x != xprevious
	image_xscale = sign(x - xprevious);
if keyboard_check_pressed(ord("Q"))
{
	helicopter = 1
}
if !grounded && sprite_index != spr_noisette_helistart && sprite_index != spr_noisette_heli && !(helicoptertime > 0)
{
	helicoptertime = 30
}
if (yprevious) > y
   vsp = -1
if (yprevious) < y
   vsp = 1
if helicoptertime <= 3 && helicoptertime != 0
{
	if !grounded && !(scr_solid(x, y+110)) && vsp == -1
		helicopter = 1
}
if helicopter == 1
{
	if !audio_is_playing(sfx_noisettefly)
	sound_play_3d(sfx_noisettefly, x, y);
	if particletime == 0
	{
		create_particle(x, y + 50, spr_cloudeffect);
	    particletime = 10
	}
}
else
{
	audio_stop_sound(sfx_noisettefly)
}
}
//coop
else
{
	/*
	var key_left = keyboard_check(ord("D"))
	var key_right = -keyboard_check(ord("A"))
		 move = key_left + key_right
		 
	mask_index = spr_player_mask
	switch state 
	{
		case 0:
		movespeed = 0
		sprite_index = spr_noisette_idle
		if  !(place_meeting(x, y+vspeed, obj_solid)) && !(place_meeting(x, y+1, obj_platform)) && !(scr_solid_slope(x - 1, y+1))
		  vspeed += 0.5
		else
		   vspeed = 0
		if move  != 0
		   state = 1
		    if keyboard_check_pressed(ord("J")) && (place_meeting(x, y+vspeed, obj_solid))
		    vspeed = -11
		   break
		case 1:
		if !(place_meeting(x, y+vspeed, obj_solid)) && !(place_meeting(x, y+1, obj_platform)) && !(scr_solid_slope(x + sign(hsp), y))
		  vspeed += 0.5
		else
		   vspeed = 0
		if sign(vspeed) = -1
		{
			if (place_meeting(x, y-vspeed, obj_solid))
			    vspeed = vspeed * -1
		}
		 if keyboard_check_pressed(ord("J")) && ((place_meeting(x, y+vspeed, obj_solid)) || place_meeting(x+movespeed * move, y-5, obj_solid) && !(place_meeting(x, y-50, obj_solid)))
		    vspeed = -15
		     if move == 0
		   {
		   state = 0
		   movespeed = 0
		   }
		   if move != 0
		   
			  image_xscale = move
		     sprite_index = spr_noisette_move
			 if movespeed <= maxmovespeed
			  movespeed += 0.5
			  	 if !place_meeting(x+movespeed * move, y-5, obj_solid)
			x += movespeed * move
			 else
			 {
			
			  
			  }

		break
		
	}
	hsp = movespeed * move
	xscale = image_xscale
	if place_meeting(x, y, obj_player) && hitbuffer <= 0
	{
		if !keyboard_check(vk_control)
		{
		    	gamepad_set_vibration(0, 0.7, 0.7);
	obj_player.alarm[4] = 3
		player.state = states.bounce;
		player.sprite_index = spr_player_bounce;
		player.movespeed = 2;
		player.vsp = -20;
		hitbuffer = 10
		player.grounded = false;
		}
		else
		{
			player.mach2 = 50;
			player.movespeed = 16;
			player.state = states.normal;
		//	state = 3;
		}
	}
	
	x = objectID.x
y = objectID.y
var cx = camera_get_view_x(view_camera[0])
var cy = camera_get_view_y(view_camera[0])
var cw = camera_get_view_width(view_camera[0])
var ch = camera_get_view_height(view_camera[0])
var edge_x = (abs(sprite_width) / 2)
var edge_y = (abs(sprite_height) / 2)
var pad = 12
var l = ((cx + edge_x) + pad)
var t = ((cy + edge_y) + pad)
var r = (((cx + cw) - edge_x) - pad)
var b = (((cy + ch) - edge_y) - pad)

if (!(collision_rectangle((l - edge_x), (t - edge_y), (r + edge_x), (b + edge_y), objectID, 0, 0)))
  maxmovespeed = 19
else
  maxmovespeed = 15
  
if distance_to_object(obj_player)>= 1200
{
   x = obj_player.x 
   y = obj_player.y
   hitbuffer = 10
}
*/
instance_destroy()
}

if hitbuffer >= 0
    hitbuffer -= 0.1