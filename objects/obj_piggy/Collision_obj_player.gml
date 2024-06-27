/// @description Insert description here
// You can write your code in this editor
instance_destroy()
audio_play_sound(sfx_oink, 5, 0)
with (instance_create(x, y, obj_debris))
{
	hspeed = obj_player.hsp + (7 * (obj_player.xscale))
	vspeed = random_range(-8, -9)
	sprite_index = other.sprite_index
}



