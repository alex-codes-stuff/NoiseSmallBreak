/// @description Insert description here
// You can write your code in this editor
if place_meeting(x, y, obj_player) && obj_player.key_down
{
	obj_player.state = states.actor
	obj_player.visible = false
	obj_player.hsp = 0
	obj_player.vsp = 0
	obj_player.x = x
	obj_player.sprite_index = spr_null
	instance_create(obj_player.x, obj_player.y, obj_explosion)
	audio_play_sound(sfx_explosion, 0, 0)
	var _sound = audio_play_sound(sfx_scream, 100, 0)
	with instance_create(obj_player.x, obj_player.y, obj_debris)
	{
		sprite_index = spr_player_stopping
		hspeed = -12
	}
	obj_player.alarm[5] = 100
	audio_sound_set_track_position(_sound, 1.9);
	instance_destroy()
}





