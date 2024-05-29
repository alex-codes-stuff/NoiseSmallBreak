/// @description Insert description here
// You can write your code in this editor

if place_meeting(x, y, obj_player) && touched == 0
{
	touched = 1;
	timer = 100
}

if !place_meeting(x, y, obj_player)
{
	touched = 0;
	
}


if timer > -1 && touched
   timer -= 1
   
if touched && timer == 0
{
	alarm[0] = 50
	obj_player.state = states.actor
	obj_player.hspeed = 10
}
