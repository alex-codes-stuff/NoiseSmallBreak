/// @description Insert description here
// You can write your code in this editor
with instance_create(x+32, y+32, obj_debris)
   sprite_index = spr_noisette_move
ds_list_add(global.saveroom, id);
obj_camera.shakestrength = 10
obj_camera.shake = 1
obj_player.alarm[3] = 12
obj_player.alarm[4] = 12
audio_play_sound(sfx_punch, 0, 0)
gamepad_set_vibration(0, 1, 1);

