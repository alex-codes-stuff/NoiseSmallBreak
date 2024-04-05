repeat 6
{
	with instance_create(x + 32, y + 32, obj_debris)
	    sprite_index = spr_destroyabledebris
	
}
obj_player.alarm[4] = 4
gamepad_set_vibration(0, 0.5, 0.5);
ds_list_add(global.saveroom, id);
