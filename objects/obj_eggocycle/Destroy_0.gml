/// @description Insert description here
// You can write your code in this editor
instance_create(x, y, obj_explosion)
with instance_create(x, y, obj_explosion)
{
    sprite_index = spr_spikehurt
	image_xscale = 1.1
	image_yscale = 1.1
}
ds_list_add(global.saveroom, id);
obj_camera.shakestrength = 10
obj_camera.shake = 1
obj_player.alarm[3] = 5
obj_player.alarm[4] = 5
repeat eggopps
   with instance_create(x+random_range(-20, 20), y -90  , obj_eggopp)
      state = 0

audio_play_sound(sfx_punch, 0, 0)
gamepad_set_vibration(0, 0.7, 0.7);


