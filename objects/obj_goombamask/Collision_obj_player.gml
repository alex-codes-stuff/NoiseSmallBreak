/// @description Insert description here
// You can write your code in this editor

if obj_player.y < y && obj_player.state != states.hurt
{
	touching = 1
	with obj_goomba
	{
	   if id == other.idd
	   {
		   if dead == 0 
		   {
			   dead = 1
			   alarm[0] = 70;
			   if obj_player.vsp > 0
			      obj_player.vsp = (obj_player.vsp * -1)
			   audio_play_sound(sfx_punch, 0, 0)
			   
		   }
	   }
	}
}




