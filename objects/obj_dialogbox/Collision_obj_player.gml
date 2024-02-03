 /// @description Insert description here
   
if (keyboard_check_pressed(vk_up) || obj_player._key_right) && (obj_player.sprite_index == spr_player_idle || obj_player.sprite_index == spr_player_stop)
{
    obj_player.state = states.actor
	obj_player.sprite_index = spr_player_idle
	obj_player.hsp = 0
	
		draw = 1
	
}

