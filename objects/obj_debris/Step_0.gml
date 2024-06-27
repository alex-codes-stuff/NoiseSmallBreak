if vspeed >= 10
	gravity = 0;
if sprite_index = spr_eggopp_dead || sprite_index = spr_bomb
    image_angle +=randomspeed
	
if sprite_index == spr_bomb && (scr_solid(x, y-15) || place_meeting(x, y, obj_eggopp)) && !place_meeting(x, y-15, obj_destroyable)
{
   instance_create(x, y, obj_explosion)
  
	   audio_play_sound(sfx_explosion, 100, 0)
   
   instance_destroy()
}