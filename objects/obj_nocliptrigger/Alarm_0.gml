/// @description Insert description here
// You can write your code in this editor
with instance_create(obj_player.x, obj_player.y, obj_hallway)
{
	visible = false
	targetRoom = smb11
	obj_player.hspeed = 0
	
	
}

with obj_player
{
			sound_play_3d(sfx_slide, x, y);
			movespeed = max(movespeed, 12);
			
			state = states.slide;
			image_index = 0;
			sprite_index = spr_player_forkstart;
}

