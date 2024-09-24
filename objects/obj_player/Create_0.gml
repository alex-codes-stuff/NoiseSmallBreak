 live_auto_call;
timer = 0
wallbounceCount = 0
tnt = 0
sintimer = 0
sinspeed = 0.1
scr_initinput()
pigtimer = 0
atepig = 0
toplayer = 0
axis_down_prev = (gamepad_axis_value(0,gp_axislv) > 0.5);
controllerConnectedPopup = 0
controllerConnected = 0
cheese_thing = 0

lasthealthbar_x = 0
noiseicon_speed = 0
_player1x = 0
_xscale = 0
_player1y = 0
scr_keycodetokeyname()
collectfont  = font_add_sprite_ext(spr_collectfont, "0123456789/", true, 0)
global.level = "junkbeach"
global.firsttime = 1
ini_open("SaveData.ini")
if ini_read_string("junkbeach", "time", "None") != "None"
   global.firsttime = 0
ini_close();
controllerfinished = 1
//make it 1 when controller bugs are fixed.
enum states
{
	normal, 
	mach,
	jump,
	slide,
	hurt,
	wallslide,
	bounce,
	actor,
	hitstun
}
#macro mach2_time 30

depth = -6;
alarm[0] = room_speed * 0.1
global.coop = 0
timerend = 0
setNewTime = 0
hp = 4;
losehp = 0
image_speed = 0.35;
hsp = 0;
vsp = 0;
grounded = false;
grav = 0.5;
state = states.normal;
hsp_carry = 0;
vsp_carry = 0;
platformid = noone;
xscale = 1;
yscale = 1;
movespeed = 0;
_move = 0
_key_left = 0
_key_right = 0
mach2 = 0;
jumpstop = false;
inv = 0;

input_buffer_jump = 0;

verticalpos = 0;
verticalspd = 0;

targetRoom = 0;
targetDoor = "A";

scr_player_addslopemomentum = function(acc, dec)
{
	with (instance_place(x, y + 1, obj_slope))
	{
		if sign(image_xscale) == -sign(other.xscale) && other.movespeed < 19
			other.movespeed += acc;
		else if other.movespeed > 12
			other.movespeed -= dec;
	}
}
scr_hurtplayer = function()
{
	if state == states.hurt or inv > 0
		exit;
	if state == states.actor
	    exit;
	hp--;
	if hp <= 0
	{
		y = 999999
		alarm[5] = 150
	}
		
	 
		   	gamepad_set_vibration(0, 1, 1);
			Vibrate(10, 50)
	if instance_exists(obj_player)
	obj_camera.shake = 1
	if global.coop
	{
		
		global.mainplayer = (global.mainplayer == obj_player ? obj_player2 : obj_player)
	}
	inv = 1
	obj_camera.shakestrength = 7
	obj_player.alarm[4] = 16
	obj_player.alarm[3] = 16
	sound_play_3d(sfx_hurt, x, y);
	grounded = false;
	movespeed = 0;
	hsp = xscale * -6;
	vsp = -10;
	state = states.hurt;
	sprite_index = spr_player_hurt;
}

// effects
machsnd = noone;
machsnd_play = noone;
part_time = 0;
jumpclouds = 0;
debuggingthisfuckingshitiwannakillmyself = 0
key_right = 0
key_left = 0
key_up = 0
key_down = 0
key_down2 = 0
key_forward = 0
move = 0

key_down2thing = 0

set_machsnd = function(sound)
{
	if machsnd == sound
		exit;
	
	if machsnd != noone
		audio_stop_sound(machsnd_play);
	
	if sound != noone
	{
		machsnd = sound;
		machsnd_play = audio_play_sound(sound, 0, true);
	}
	else
		machsnd = noone;
}
