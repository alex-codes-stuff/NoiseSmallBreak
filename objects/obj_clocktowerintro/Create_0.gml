/// @description Insert description here
// You can write your code in this editor
if obj_player.targetDoor != "B"
{
with obj_player
{
	state = states.actor
	sprite_index = spr_player_clocktowerintro1
	image_index = 0
	xscale = 1
	hsp = 0
	movespeed = 0
}
alarm[0] = 100
radius = 100
surface = -4
objectID = obj_player
objectID2 = obj_bigjoey
ended = 0
}
else
	instance_destroy()



