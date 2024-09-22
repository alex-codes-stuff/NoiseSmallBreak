  live_auto_call;
if y > room_height + 500 && !instance_exists(obj_technicaldifficulty)
{
	if !(hp <= 0)
	{
	 instance_create(x, y, obj_technicaldifficulty)
	}
	 
}
if room == room_editor && global.play != 1 || room == room_upload
{
	visible = false
	return;
}
else
   visible = true
   /*
if !keyboard_check(vk_control) && keyboard_check_pressed(ord("R"))
{
	ds_list_clear(global.saveroom);
	event_perform(ev_create, 0);F
	
	targetDoor = "";
	//audio_stop_all();
	room_restart();
	
}
*/
if room == hub_1
{
   timer = 0
   timerend = 0  
}
if (keyboard_check_pressed(ord("T")) || gamepad_button_check(0, gp_select)) && room != room_customlevel  && room != room_editor
   global.timeattack = (global.timeattack ? 0 : 1)
if gamepad_is_connected(0)
{
	if controllerConnectedPopup == 0
	{
		controllerConnectedPopup = 1
		controllerConnected = 1
		alarm[7] = 200
	}
}
//controllers fixed now, still wanna add a way to press 2 direction keys at once though,,
ini_open("keybinds.ini")
if global.coop == 0
{

if !gamepad_is_connected(0) || os_type == os_android 
{
	//left
	var check = global.keys[? ini_read_string("keybinds", "key_left", "vk_left")]
	if !is_undefined(check)
		key_left = -keyboard_check(global.keys[? ini_read_string("keybinds", "key_left", "vk_left")])
	else
	    	key_left = -keyboard_check(ord(ini_read_string("keybinds", "key_left", "A")))
			//right
	var check = global.keys[? ini_read_string("keybinds", "key_right", "vk_right")]
	if !is_undefined(check)
		key_right = keyboard_check(global.keys[? ini_read_string("keybinds", "key_right", "vk_right")])
	else
	    	key_right = keyboard_check(ord(ini_read_string("keybinds", "key_right", "D")))
			//up
	var check = global.keys[? ini_read_string("keybinds", "key_up", "vk_up")]
	if !is_undefined(check)
		key_up = keyboard_check(global.keys[? ini_read_string("keybinds", "key_up", "vk_up")])
	else
	    	key_up = keyboard_check(ord(ini_read_string("keybinds", "key_up", "W")))
			//down
	var check = global.keys[? ini_read_string("keybinds", "key_down", "vk_down")]
	if !is_undefined(check)
	{
		key_down = keyboard_check(global.keys[? ini_read_string("keybinds", "key_down", "vk_down")])
		key_down2 = keyboard_check_pressed(global.keys[? ini_read_string("keybinds", "key_down", "vk_down")])
		
	}
	else
	{
	    	key_down = keyboard_check(ord(ini_read_string("keybinds", "key_down", "S")))
			key_down2 = keyboard_check_pressed(ord(ini_read_string("keybinds", "key_down", "S")))
	}
//key_down2 = keyboard_check_pressed(global.keys[? ini_read_string("keybinds", "key_down", "vk_down")])
//jump
	var check = global.keys[? ini_read_string("keybinds", "key_jump", "Z")]
	if !is_undefined(check)
	{
		key_jump = keyboard_check_pressed(global.keys[? ini_read_string("keybinds", "key_jump", "Z")])
		key_jump2 = keyboard_check(global.keys[? ini_read_string("keybinds", "key_jump", "Z")])
		
	}
	else
	{
	    	key_jump = keyboard_check_pressed(ord(ini_read_string("keybinds", "key_jump", "Z")))
			key_jump2 = keyboard_check(ord(ini_read_string("keybinds", "key_jump", "Z")))
	}
//key_jump2 = keyboard_check(ord(ini_read_string("keybinds", "key_jump", "Z")))

	with obj_joystickmove
	{
	
		if place_meeting(x-30, y, obj_joystick_right)
		   obj_player.key_right = 1
	    if place_meeting(x+30, y, obj_joystick_left)
		   obj_player.key_left = -1
		if place_meeting(x, y+25, obj_joystick_up)
		   obj_player.key_up = 1
		 if !place_meeting(x, y-25, obj_joystick_down)
		{
		  obj_player.key_down2thing = 0
		}
		if place_meeting(x, y-25, obj_joystick_down)
		{
		   obj_player.key_down = 1
		   if obj_player.key_down2thing == 0
				 obj_player.key_down2 = 1
		}

	
	}
  debuggingthisfuckingshitiwannakillmyself = 0
  move = key_left + key_right;
  forward = gamepad_button_check(0, gp_shoulderrb)
}
else if controllerfinished == 1
{
  if global.coop == 0
  {
	debuggingthisfuckingshitiwannakillmyself = 1
	key_right =gamepad_axis_value(0, gp_axislh) > 0.5 //|| gamepad_button_check(0, gp_shoulderrb) && !((gamepad_axis_value(0, gp_axislh) < -0.5) *-1)
	key_left  =((gamepad_axis_value(0, gp_axislh) < -0.5) *-1) 
	
	key_up =  (gamepad_axis_value(0, gp_axislv) < -0.5)
	key_down = gamepad_axis_value(0, gp_axislv) > 0.5
	_key_right = key_up
	_key_left = key_down
	var _keydown2 = 0
	
	if _keydown2 == false && axis_down_prev == false
	{
		if gamepad_axis_value(0, gp_axislv) > 0.5
	    {
			 _keydown2 = true;
	    }
	}
	
	key_down2 = _keydown2
	
	key_jump = gamepad_button_check_pressed(0, global.keys[? ini_read_string("keybinds", "key_jumpC", "gp_face1")])
	key_jump2 = gamepad_button_check(0,global.keys[? ini_read_string("keybinds", "key_jumpC", "gp_face1")])
	
	key_forward = gamepad_button_check(0, global.keys[? ini_read_string("keybinds", "key_forwardC", "gp_shoulderrb")]) * xscale
	if !gamepad_button_check(0,global.keys[? ini_read_string("keybinds", "key_forwardC", "gp_shoulderrb")])
	 move = key_left + key_right
	else
	 move = key_forward
	_move = move
  }

}
}

ini_close()

//mobiler!!


if key_jump
	input_buffer_jump = 10;
if input_buffer_jump > 0
	input_buffer_jump--;

switch state
{
	case states.normal:
		hsp = xscale * movespeed;
		
		if (place_meeting(x + sign(hsp), y, obj_solid) or scr_solid_slope(x + sign(hsp), y))
		&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12)
		{
			if place_meeting(x, y + 1, obj_slope)
			{
				vsp = -movespeed;
				sound_play_3d(sfx_wallslide, x, y);
			
				state = states.wallslide;
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
				sprite_index = spr_player_mach2;
		}
		else if movespeed == 0
			sprite_index = spr_player_idle;
		
		if movespeed < 12
			mach2 = 0;
		
		if move != xscale && movespeed > 0
		{
			if sprite_index != spr_player_stopping
			{
				create_particle(x, y, spr_dashcloud, xscale);
				if mach2 >= mach2_time
				{
					audio_stop_sound(sfx_stop);
					sound_play_3d(sfx_stop, x, y);
				}
				sprite_index = spr_player_stopping;
			}
			mach2 = 0;
			
			movespeed = Approach(movespeed, 0, 0.8);
			if movespeed == 0 && move != 0
			{
				xscale = move;
				image_index = 0;
				sprite_index = spr_player_turn;
			}
			else if movespeed == 0
			{
				image_index = 0;
				sprite_index = spr_player_stop;
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
			if sprite_index != spr_player_mach1 && sprite_index != spr_player_mach2 && sprite_index != spr_player_mach3 && sprite_index != spr_player_runland && sprite_index != spr_player_turn
			{
				image_index = 0;
				sprite_index = spr_player_mach1;
			}
			if image_index >= image_number - 1 && (sprite_index == spr_player_mach1 or sprite_index == spr_player_runland or sprite_index == spr_player_turn)
				sprite_index = spr_player_mach2;
			
			if mach2 < mach2_time && movespeed <= 12
			{
				if movespeed < 12
					movespeed += 0.4;
				else
					mach2++;
			}
			else
			{
				mach2 = mach2_time;
				
				sprite_index = spr_player_mach3;
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
			state = states.jump;
			
			if xscale != move && move != 0
			{
				sound_play_3d(sfx_jump, x, y);
				sprite_index = spr_player_backflip;
				vsp = -16;
				xscale = move;
				movespeed = 2;
				
				jumpclouds = 10;
			}
			else if mach2 >= mach2_time
			{
				sound_play_3d(sfx_highjump, x, y);
				sprite_index = spr_player_glidejumpstart;
				vsp = -16.2;
				//junk beach skip pawsible?
				jumpclouds = 10;
			}
			else
			{
				sound_play_3d(sfx_jump, x, y);
				vsp = -14;
				
				if movespeed >= 12
				{
					sprite_index = spr_player_mach2jump;
					jumpclouds = 10;
				}
				else
					sprite_index = spr_player_jump;
			}
		}
		
		if !grounded
		{
			state = states.jump;
			sprite_index = spr_player_fall;
		}
		else if key_down2
		{
			if !((place_meeting(x + sign(hsp)*3, y, obj_solid) or scr_solid_slope(x + sign(hsp)*3, y))
			&& !place_meeting(x + hsp, y, obj_destroyable))
			
			{
			sound_play_3d(sfx_slide, x, y);
			movespeed = max(movespeed, 12);
			
			state = states.slide;
			image_index = 0;
			sprite_index = spr_player_forkstart;
			}
		}
		break;
	
	case states.jump:
	case states.bounce:
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
		if sprite_index != spr_player_bounce 
	    {
			
		if move != xscale
		{
			var spd = 0.4;
			if move == 0
				spd = 0.1;
				
			
			if sprite_index == spr_player_glidejump
			  spd = 0.7
			  
			 
				movespeed = Approach(movespeed, 0, move == 0 ? 0.1 : spd);
			
			if movespeed == 0 && move != 0 && sprite_index != spr_player_backflip && sprite_index != spr_player_backflipfall
				xscale = move;
		}
		else if movespeed < 13
		{
			var spd = 0.4;
			if sprite_index == spr_player_backflip
				spd = 0.2;
			movespeed = Approach(movespeed, 13, spd);
		}
		}
		else
		{
			if obj_player.key_jump && scr_solid(x+(hsp), y)
			{
				audio_play_sound(sfx_boing, 0, false, 1.2)
				vsp = -18 + (wallbounceCount*2)
				wallbounceCount += 1
				image_index = 0
			}
			if move != xscale
		{
			if !scr_solid(x+(hsp), y)
				movespeed = Approach(movespeed, 0, move == 0 ? 0.2 : 0.5);
			else
			   movespeed = Approach(movespeed, 0, 2);
			
			if movespeed == 0 && move != 0 && sprite_index != spr_player_backflip && sprite_index != spr_player_backflipfall
				xscale = move;
		}
		else if movespeed < 13
		{
			
			movespeed = Approach(movespeed, 13, 1);
		}
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
					sprite_index = spr_player_fall;
					break;
				case spr_player_glidejumpstart:
					sprite_index = spr_player_glidejump;
					break;
				case spr_player_glidefallstart:
					sprite_index = spr_player_glidefall;
					break;
				case spr_player_mach2jump:
					sprite_index = spr_player_mach2fall;
					break;
				case spr_player_backflip:
					sprite_index = spr_player_backflipfall;
					break;
			}
		}
		
		if grounded
		{
			create_particle(x, y, spr_landcloud);
			sound_play_3d(sfx_land, x, y);
			
			state = states.normal;
			image_index = 0;
			sprite_index = move != 0 ? spr_player_runland : spr_player_idle;
		}
		
		if place_meeting(x + sign(hsp), y, obj_solid)
		&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12)
		{
			if state == states.bounce
				movespeed = 0;
			else
			{
				if (sprite_index != spr_player_bounce)
				{
					sound_play_3d(sfx_wallslide, x, y);
			
					state = states.wallslide;
					sprite_index = spr_player_wallslide;
					vsp = min(vsp, 0);
				}
			}
		}
		
		if movespeed > 2 && key_down2
		{
			if !(sprite_index = spr_player_longjump)
			{
				if sprite_index != spr_player_bounce
				{
					sound_play_3d(sfx_groundpound, x, y);
			
					state = states.slide;
					sprite_index = spr_player_dive;
					vsp = 13;
				}
				else if !scr_solid(x+hsp, y)
				{
					sound_play_3d(sfx_groundpound, x, y);
			
					state = states.slide;
					sprite_index = spr_player_dive;
					vsp = 13;
				}
			}
			else if image_index >= 4
			{
					sound_play_3d(sfx_groundpound, x, y);
			
				state = states.slide;
				sprite_index = spr_player_dive;
				vsp = 13;
			}
		}
		break;
	
	case states.wallslide:
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
			state = states.normal;
		}
		vsp = min(vsp, 9);
		
		sprite_index = vsp > 0 ? spr_player_wallslidedown : spr_player_wallslide;

		
		if !place_meeting(x + xscale, y, obj_solid) or move == -xscale
		{
			sprite_index = spr_player_fall;
			image_index = 0;
			state = states.jump;
		}
		else if input_buffer_jump
		{
			input_buffer_jump = 0;
			sound_play_3d(sfx_jump, x, y);
			
			//xscale *= -1;
			movespeed = 10;
			state = states.jump;
			audio_play_sound(sfx_boing, 0, false, 1.2)
			sprite_index = spr_player_bounce;
			vsp = -19;
		}
		break;
	
	case states.slide:
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
				
				state = states.normal;
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
					state = states.normal;
			
				if input_buffer_jump
				{
					input_buffer_jump = 0;
					sound_play_3d(sfx_jump, x, y);
					create_particle(x, y, spr_highjumpcloud2);
				
					jumpstop = false;
					sprite_index = spr_player_longjump;
					image_index = 0;
					movespeed += 2
					state = states.jump;
					vsp = -12;
					jumpclouds = 12;
				}
				scr_player_addslopemomentum(0.4, 0.2);
			}
		}
		else if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + hsp, y, obj_destroyable)
		{
			sound_play_3d(sfx_wallslide, x, y);
			
			state = states.wallslide;
			if vsp > 0
			{
			   vsp  = -vsp
			   vsp -= 2
			}
			sprite_index = spr_player_wallslide;
		}
		//nuh...
		/*
		if !grounded && sprite_index == spr_player_crouchslip
		{
			sprite_index = spr_player_dive
			vsp = 13
		}
		*/
		
		break;
	
	case states.hurt:
		if grounded && vsp >= 0
		{
			state = states.normal;
			movespeed = 0;  
			if global.level == "junkbeach"
			{ 
			if !(global.timeattack && timer >= 59.99)
				inv = 80;
		    else
			   inv = 0
			}
			else
			{
 			   	if !(global.timeattack && timer >= 170)
				inv = 80;
				else
				inv = 0
			}
		}
		break;
}

if grounded && state == states.normal
{
	if movespeed > 12
		set_machsnd(sfx_mach3);
	else if sprite_index == spr_player_mach2
		set_machsnd(sfx_mach2);
	else if sprite_index == spr_player_mach1
		set_machsnd(sfx_mach1);
	else
		set_machsnd(noone);
}
else
	set_machsnd(noone);

if state != states.jump && state != states.normal
	mach2 = 0;

if state == states.wallslide or (state == states.jump && mach2 >= mach2_time && vsp < 0)
	grav = 0.25;
else
	grav = 0.5;

// collide destructibles
if state == states.bounce
{
	with instance_place(x, y + vsp + 1, obj_destroyable)
	{
		other.vsp = -14;
		other.grounded = false;
		instance_destroy();
	}
}
if movespeed > 12 or state == states.slide
{
	with instance_place(x + hsp, y, obj_destroyable)
		instance_destroy();
	with instance_place(x, y + vsp + 1, obj_destroyable)
		instance_destroy();
}
if !instance_exists(obj_minime)
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
	if sprite_index == spr_player_bounce
	{
		vsp = -14;
		grounded = false;
	}
	else
		scr_hurtplayer();
}
//*
//if mouse_check_button_pressed(mb_left)
//{
//	x = mouse_x;
//	y = mouse_y;
// }
if global.mainplayer == obj_player2
{
if distance_to_object(global.mainplayer)>= 1200
{
	toplayer = 1
}
if toplayer == 1
{
	if state != states.actor
	{
		
		_xscale = global.mainplayer.xscale
	}
	_player1x = global.mainplayer.x
		_player1y = global.mainplayer.y
    state = states.actor
	if distance_to_object(global.mainplayer)<= 1500
	{
		x = Approach(x, _player1x, 30)
		y = Approach(y, _player1y, 30)
	}
	hsp = 0
	vsp = 0
	movespeed = 0
	if _xscale == 1
	{
		if x >= _player1x  
		{
			speed = 0
			toplayer = 0
			state = states.normal
			
		}
	}
	if _xscale == -1
	{
		if x <= _player1x  
		{
			speed = 0
			toplayer = 0
			state = states.normal
			
		}
	}
}	
if distance_to_object(global.mainplayer) >= 1500 || y > room_height+100
{
   x = global.mainplayer.x
   y = global.mainplayer.y
}
}
if sprite_index != spr_player_bounce
   wallbounceCount = 0
if input_buffer_jump && sprite_index == spr_player_longjump
		{
				input_buffer_jump = 0;
			sound_play_3d(sfx_jump, x, y);
			
			//xscale *= -1;
			movespeed += 1
			state = states.jump;
			audio_play_sound(sfx_boing, 0, false, 1.2)
			sprite_index = spr_player_bounce;
			vsp = -16;
		}
/*
if keyboard_check_pressed(vk_rcontrol)
{
	global.mainplayer = (global.mainplayer == obj_player ? obj_player2 : obj_player)
}
*/
if (keyboard_check_pressed(vk_escape) ||gamepad_button_check_pressed(0, gp_start)) && !instance_exists(obj_minime) && room != room_editor && room != rm_changelog
{
	audio_pause_all()
    with all 
	{
		if object_index != obj_solid && object_index != obj_slope && object_index != obj_platform && object_index != obj_camera && object_index != obj_screensizer
		   instance_deactivate_object(self)
	}
	
	instance_create(x, y, obj_minime)
	with obj_minime
	{
		pauseScreenshot=sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
	}
    
}
if timerend == 1 && setNewTime == 0
{
       setNewTime = 1
	   ini_open("SaveData.ini")
	   if ini_key_exists(global.level, "time")
	   {
		   if timer < real(ini_read_string(global.level, "time", 9999999))
		   {
			   ini_write_string(global.level, "time", string(timer))
		   }
	   }
	   else
	   {
		   ini_write_string(global.level, "time", string(timer))
	   }
	   ini_close()
}
if timerend == 0
{
	setNewTime = 0
}
sintimer += sinspeed
noiseicon_speed += 0.4