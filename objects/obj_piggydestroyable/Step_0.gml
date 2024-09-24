/// @description Insert description here
// You can write your code in this editor
var inst = instance_place(x, y+15, obj_debris)
if instance_exists(inst)
{
	if inst.sprite_index == spr_bomb
		instance_destroy()
}





