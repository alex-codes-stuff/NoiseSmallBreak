/// @description Insert description here
// You can write your code in this editor
if visible
{
	if other.tnt == 0
	{
		visible = false
		alarm[0] = 150
		audio_play_sound(sfx_oink, 5, 0)
		with (instance_create(x, y, obj_debris))
		{
			hspeed = (21 * (obj_player.xscale))
			vspeed = - 10
			sprite_index = other.sprite_index
		}
	}
	else
	{
		alarm[0] = 150
		visible = false
		audio_play_sound(sfx_oink, 5, 0, 1, 0, 1.2)
		audio_play_sound(sfx_burp, 5, 0)
		other.atepig = 1
		other.alarm[8] = 1
		other.pigtimer = pigtimer_time
	}
}



