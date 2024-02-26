  live_auto_call;
if global.coop == 0
  instance_destroy()
if room == room_editor && global.play != 1
{
	visible = false
	return;
}
else
   visible = true
if !keyboard_check(vk_control) && keyboard_check_pressed(ord("R"))
{
	ds_list_clear(global.saveroom);
	event_perform(ev_create, 0);
	targetDoor = "";
	//audio_stop_all();
	room_restart();
}
if room == hub_1
{
   timer = 0
   timerend = 0  
}
if keyboard_check_pressed(ord("T")) || gamepad_button_check(0, gp_select)
   global.timeattack = 1
if room == testroom_1 && targetDoor = "X"
   timerend = 1
//controllers fixed now, still wanna add a way to press 2 direction keys at once though,,
if !gamepad_is_connected(0) || os_type == os_android
{
var key_left = -keyboard_check(ord("A"));
var key_right = keyboard_check(ord("D"));
var key_up = keyboard_check(ord("W"));
var key_down = keyboard_check(ord("S"));
var key_down2 = keyboard_check_pressed(ord("S"));
var key_jump = keyboard_check_pressed(ord("J"));
var key_jump2 = keyboard_check(ord("J"));
var move = key_left + key_right;
var forward = gamepad_button_check(0, gp_shoulderrb)
}
else if controllerfinished == 1
{
	var key_right =gamepad_axis_value(0, gp_axislh) > 0.5 //|| gamepad_button_check(0, gp_shoulderrb) && !((gamepad_axis_value(0, gp_axislh) < -0.5) *-1)
	var key_left  =((gamepad_axis_value(0, gp_axislh) < -0.5) *-1) 
	
	var key_up =  (gamepad_axis_value(0, gp_axislv) < -0.5)
	var key_down = gamepad_axis_value(0, gp_axislv) > 0.5
	_key_right = key_up
	_key_left = key_down
	var key_down2 = gamepad_axis_value(0, gp_axislv) > 0.5
	var key_jump = gamepad_button_check_pressed(0, gp_face1)
	var key_jump2 = gamepad_button_check(0, gp_face1)
	
	var key_forward = gamepad_button_check(0, gp_shoulderrb) * xscale
	if !gamepad_button_check(0, gp_shoulderrb)
	var move = key_left + key_right
	else
	var move = key_forward
	_move = move

}

if key_jump
	input_buffer_jump = 10;
if input_buffer_jump > 0
	input_buffer_jump--;

switch state
{
	case states2.normal:
		hsp = xscale * movespeed;
		
		if (place_meeting(x + sign(hsp), y, obj_solid) or scr_solid_slope(x + sign(hsp), y))
		&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12)
		{
			if place_meeting(x, y + 1, obj_slope)
			{
				vsp = -movespeed;
				sound_play_3d(sfx_wallslide, x, y);
			
				state = states2.wallslide;
				sprite_index = spr_player_wallslide;
				grounded = false;
				movespeed = 0;
				
				exit;
			}
			movespeed = 0;
		}
		
		if sprite_index == spr_player_stop
		{
			if image_index >= image_number - 1
			{
				image_index = 0;
				sprite_index = spr_player_idle;
			}
		}
		else if sprite_index == spr_player_turn
		{
			if image_index >= image_number - 1
				sprite_index = spr_noisette_move;
		}
		else if movespeed == 0
			sprite_index = spr_noisette_idle;
		
		if movespeed < 12
			mach2 = 0;
		
		if move != xscale && movespeed > 0
		{
			if sprite_index != spr_noisette_idle
			{
				create_particle(x, y, spr_dashcloud, xscale);
				if mach2 >= mach2_time2
				{
					audio_stop_sound(sfx_stop);
					sound_play_3d(sfx_stop, x, y);
				}
				sprite_index = spr_noisette_idle;
			}
			mach2 = 0;
			
			movespeed = Approach(movespeed, 0, 0.7);
			if movespeed == 0 && move != 0
			{
				xscale = move;
				image_index = 0;
				sprite_index = spr_noisette_move;
			}
			else if movespeed == 0
			{
				image_index = 0;
				sprite_index = spr_noisette_idle
			}
		}
		else if move != 0 && !place_meeting(x + move, y, obj_solid)
		{
			if ++part_time >= 16
			{
				part_time = 0;
				create_particle(x, y, spr_dashcloud, xscale);
			}
			
			xscale = move;
			if sprite_index != spr_noisette_move && sprite_index != spr_player_runland && sprite_index != spr_player_turn
			{
				image_index = 0;
				sprite_index = spr_noisette_move;
			}
			
			if mach2 < mach2_time2 && movespeed <= 12
			{
				if movespeed < 12
					movespeed += 0.4;
				else
					mach2++;
			}
			else
			{
				mach2 = mach2_time2;
				
			//	sprite_index = spr_spr_noisette_move;
				if movespeed < 16
					movespeed = Approach(movespeed, 16, 0.4);
				else if movespeed < 19
					movespeed = Approach(movespeed, 19, 0.01);
			}
			scr_player_addslopemomentum(0.08, 0.04);
		}
		
		if input_buffer_jump
		{
			input_buffer_jump = 0;
			create_particle(x, y, spr_highjumpcloud2);
			
			jumpstop = false;
			state = states2.jump;
			
			
				sound_play_3d(sfx_jump, x, y);
				vsp = -14;
				
				if movespeed >= 12
				{
					sprite_index = spr_noisette_move;
					jumpclouds = 10;
				}
				else
					sprite_index = spr_player_jump;
			
		}
		
		if !grounded
		{
			state = states2.jump;
			sprite_index = spr_noisette_move;
		}
		
		break;
	
	case states2.jump:
	case states2.bounce:
		hsp = xscale * movespeed;
		
		if --jumpclouds > 0 && vsp < 0
		{
			if ++part_time >= (16 - jumpclouds) / 3
			{
				part_time = 0;
				
				create_particle(x, y + 50, spr_cloudeffect);
			}
		}
		else if movespeed >= 16
		{
			if ++part_time >= 8
			{
				part_time = 0;
				create_particle(x, y, spr_cloudeffect);
			}
		}
		
		if !jumpstop && !key_jump2 && vsp < 0
		{
			jumpstop = true;
			vsp = 0;
		}
		
		if move != xscale
		{
			var spd = 0.4;
			if move == 0
				spd = 0.1;
			
			movespeed = Approach(movespeed, 0, move == 0 ? 0.1 : 0.4);
			if movespeed == 0 && move != 0 && sprite_index != spr_player_backflip && sprite_index != spr_player_backflipfall
				xscale = move;
		}
		else if movespeed < 10
		{
			var spd = 0.4;
			if sprite_index == spr_player_backflip
				spd = 0.2;
			movespeed = Approach(movespeed, 10, spd);
		}
		
		if sprite_index == spr_player_glidejump && vsp >= 0
		{
			image_index = 0;
			sprite_index = spr_player_glidefallstart;
		}
		
		if image_index >= image_number - 1
		{
			switch sprite_index
			{
				case spr_player_jump:
					sprite_index = spr_noisette_move;
					break;
				case spr_player_glidejumpstart:
					sprite_index = spr_player_glidejump;
					break;
				case spr_player_glidefallstart:
					sprite_index = spr_player_glidefall;
					break;
				case spr_noisette_move:
					sprite_index = spr_noisette_move;
					break;
				case spr_player_backflip:
					sprite_index = spr_player_backflipfall;
					break;
				case spr_player_runland:
					sprite_index = spr_noisette_move;
					break;
			}
		}
		
		if grounded
		{
			create_particle(x, y, spr_landcloud);
			sound_play_3d(sfx_land, x, y);
			
			state = states2.normal;
			image_index = 0;
			sprite_index = spr_noisette_idle
		}
		
		if place_meeting(x + sign(hsp), y, obj_solid)
		&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12)
		{
			if state == states2.bounce
				movespeed = 0;
			else
			{
				sound_play_3d(sfx_wallslide, x, y);
			
				state = states2.wallslide;
				sprite_index = spr_player_wallslide;
				vsp = min(vsp, 0);
			}
		}
		
		
		break;
	
	case states2.wallslide:
		movespeed = 0;
		
		if ++part_time >= 8
		{
			part_time = 0;
			create_particle(x + xscale * 10, y, spr_cloudeffect);
		}
		
		if grounded
		{
			sound_play_3d(sfx_land, x, y);
			create_particle(x, y, spr_landcloud);
			state = states2.normal;
		}
		vsp = min(vsp, 8);
		
		sprite_index = vsp > 0 ? spr_player_wallslidedown : spr_player_wallslide;

		
		if !place_meeting(x + xscale, y, obj_solid) or move == -xscale
		{
			sprite_index = spr_noisette_idle;
			image_index = 0;
			state = states2.jump;
		}
		else if input_buffer_jump
		{
			input_buffer_jump = 0;
			sound_play_3d(sfx_jump, x, y);
			
			xscale *= -1;
			movespeed = 10;
			state = states2.jump;
			audio_play_sound(sfx_boing, 0, false, 1.2)
			sprite_index = spr_player_bounce;
			vsp = -14;
		}
		break;
	
	case states2.slide:
		hsp = xscale * movespeed;
		if (place_meeting(x + sign(hsp), y, obj_solid) or scr_solid_slope(x + sign(hsp), y))
		&& !place_meeting(x + hsp, y, obj_destroyable)
		{
			xscale = xscale * -1
			movespeed -= 3
		}
		if sprite_index == spr_player_forkstart && image_index >= image_number - 1
			sprite_index = spr_player_crouchslip;
		if grounded
		{
			if sprite_index == spr_player_dive
			{
				sound_play_3d(sfx_land, x, y);
				
				state = states2.normal;
				sprite_index = spr_player_runland;
				image_index = 0;
			}
			else
			{
				if ++part_time >= 16
				{
					part_time = 0;
					create_particle(x, y, spr_dashcloud, xscale);
				}
				movespeed = Approach(movespeed, 0, 0.05);
			
				if movespeed <= 0
					state = states2.normal;
			
				if input_buffer_jump
				{
					input_buffer_jump = 0;
					sound_play_3d(sfx_jump, x, y);
					create_particle(x, y, spr_highjumpcloud2);
				
					jumpstop = false;
					sprite_index = spr_player_longjump;
					image_index = 0;
					movespeed += 2
					state = states2.jump;
					vsp = -12;
					jumpclouds = 12;
				}
				scr_player_addslopemomentum(0.4, 0.2);
			}
		}
		else if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + hsp, y, obj_destroyable)
		{
			sound_play_3d(sfx_wallslide, x, y);
			
			state = states2.wallslide;
			sprite_index = spr_player_wallslide;
		}
		break;
	
	case states2.hurt:
		if grounded && vsp >= 0
		{
			state = states2.normal;
			movespeed = 0;  
			if global.level == "junkbeach"
			{ 
			if !(global.timeattack && timer >= 49.99)
				inv = 80;
			}
			else
			{
 			   	if !(global.timeattack && timer >= 160)
				inv = 80;
			}
		}
		break;
}

if grounded && state == states2.normal
{
	if movespeed > 12
		set_machsnd(sfx_mach3);
	else if sprite_index == spr_noisette_move
		set_machsnd(sfx_mach2);
	else if sprite_index == spr_noisette_move
		set_machsnd(sfx_mach1);
	else
		set_machsnd(noone);
}
else
	set_machsnd(noone);

if state != states2.jump && state != states2.normal
	mach2 = 0;

if state == states2.wallslide or (state == states2.jump && mach2 >= mach2_time2 && vsp < 0)
	grav = 0.25;
else
	grav = 0.5;

// collide destructibles
if state == states2.bounce
{
	with instance_place(x, y + vsp + 1, obj_destroyable)
	{
		other.vsp = -14;
		other.grounded = false;
		instance_destroy();
	}
}
if movespeed > 12 or state == states2.slide
{
	with instance_place(x + hsp, y, obj_destroyable)
		instance_destroy();
	with instance_place(x, y + vsp + 1, obj_destroyable)
		instance_destroy();
}

scr_collide_player();

if inv > 0
{
	image_alpha = 1 - (floor(inv / 3) % 2);
	inv--;
}
else
{
	image_alpha = 1;
	inv = 0;
}

// spikes
var spike = instance_nearest(x, y, obj_spike);
if spike && abs(distance_to_object(spike)) < 1
{
	if state == states2.bounce
	{
		vsp = -14;
		grounded = false;
	}
	//else
	//	scr_hurtplayer();
}
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
if hitbuffer >= 0
   hitbuffer -= 0.1
if distance_to_object(obj_player)>= 1200
{
   x = obj_player.x 
   y = obj_player.y
   hitbuffer = 10
}
//*
//if mouse_check_button_pressed(mb_left)
//{
//	x = mouse_x;
//	y = mouse_y;
// }
