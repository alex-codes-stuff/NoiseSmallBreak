/// @description Insert description here
// You can write your code in this editor
if sprite_index = spr_runturn && floor(image_index) == image_number - 1
{
	image_index = 0
	
	sprite_index = spr_run
}
if run == 1
{
	hspeed += 0.5
}
if hspeed > 25
    instance_destroy()




