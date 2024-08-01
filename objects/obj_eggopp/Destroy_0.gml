/// @description Insert description here
// You can write your code in this editor
if room == room_editor && global.play == 0
   return;
with instance_create(x+32, y+32, obj_debris)
{
   sprite_index = spr_eggopp_dead
 
   vspeed = random_range(-14, -12)
   hspeed = obj_player.hsp* random_range(1, 1.2)
   image_xscale = obj_player.xscale 
}
with instance_create(x+32, y+32, obj_debris)
{
   sprite_index = spr_eggopp_hat
   image_speed = 0.3
   vspeed = random_range(-16, -14)
    hspeed = obj_player.hsp * random_range(1.2, 1.3)
	 image_xscale = obj_player.xscale
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
if ++global.collect >= 30 && obj_player.hp < 7
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


