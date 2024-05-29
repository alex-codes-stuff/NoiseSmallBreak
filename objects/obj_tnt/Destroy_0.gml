/// @description Insert description here
// You can write your code in this editor
repeat 6
	with instance_create(x + 32, y + 32, obj_debris) 
	   sprite_index = spr_tntDebris
instance_create(x, y, obj_explosion)
audio_play_sound(sfx_punch, 0, 0)
ds_list_add(global.saveroom, id);


