/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x-1, y, obj_player) || place_meeting(x+1, y, obj_player)) && obj_player.tnt == 1
{
	 obj_player.alarm[6] = 300
     instance_destroy() 
	
}
if (place_meeting(x, y-1, obj_player) || place_meeting(x, y+1, obj_player)) && obj_player.tnt == 1
{
     instance_destroy() 
	obj_player.alarm[6] = 300
}



