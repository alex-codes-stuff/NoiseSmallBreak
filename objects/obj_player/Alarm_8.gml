/// @description Insert description here
// You can write your code in this editor
if pigtimer > 0
{
	alarm[8] = 1
	pigtimer -= 0.1
}
else
{
	audio_play_sound(sfx_oink, 5, 0)
	with (instance_create(x, y, obj_debris))
	{
		hspeed = 20 * (obj_player.xscale)
		vspeed = - 10
		sprite_index = spr_bomb
	}
	atepig = 0
}





