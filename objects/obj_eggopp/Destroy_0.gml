/// @description Insert description here
// You can write your code in this editor
if room == room_editor && global.play == 0
   return;
with instance_create(x+32, y+32, obj_debris)
{
   sprite_index = spr_eggopp_idle
 
   vspeed = random_range(-10, -8)
}
instance_create(x, y, obj_explosion)
with instance_create(x, y, obj_explosion)
{
    sprite_index = spr_spikehurt
	image_xscale = 1.1
	image_yscale = 1.1
}
ds_list_add(global.saveroom, id);
obj_camera.shakestrength = 10
if ++global.collect >= 20 && obj_player.hp < 8
{
	global.collect = 0;
	obj_player.hp++;
}
global.points += 5
obj_camera.shake = 1
obj_player.alarm[3] = 12
obj_player.alarm[4] = 12
audio_play_sound(sfx_punch, 0, 0)
gamepad_set_vibration(0, 0.7, 0.7);


