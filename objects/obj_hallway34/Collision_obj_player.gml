if obj_player.key_up && obj_player.grounded && obj_player.state = states.normal && !(targetRoom == room_minimenu && os_type == os_android)
{
	alarm[0] = 120
	sprite_index = spr_shuttle_move
	image_speed = 0.3
	obj_player.visible = false
	obj_player.state = states.actor
	obj_player.hsp = 0
	obj_player.vsp = 0
	obj_player.movespeed = 0
	obj_player.sprite_index = spr_null
	audio_stop_sound(mu_smb)
}
