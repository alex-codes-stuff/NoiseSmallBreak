/// @description Insert description here
// You can write your code in this editor
with obj_goombamask
   if idd = other.id
       if touching
	      other.touchingplayer = 1
if !dead && obj_player.state != states.slide && !touchingplayer 
   with obj_player
      scr_hurtplayer()
else if obj_player.state = states.slide && !dead
{
	dead = 1
	alarm[0] = 70
	audio_play_sound(sfx_punch, 0, 0)
}






