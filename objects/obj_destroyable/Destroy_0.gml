repeat 6
	instance_create(x + 32, y + 32, obj_debris);
obj_player.alarm[4] = 4
gamepad_set_vibration(0, 0.5, 0.5);
ds_list_add(global.saveroom, id);
