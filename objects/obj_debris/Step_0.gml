if vspeed >= 10
	gravity = 0;
if sprite_index = spr_eggopp_dead || sprite_index = spr_bomb
    image_angle +=randomspeed
	
if sprite_index == spr_bomb && (scr_solid(x, y-10) || place_meeting(x, y-10, obj_eggopp)) && !place_meeting(x, y, obj_destroyable) && !place_meeting(x, y, obj_piggy_bounceblock)  && !place_meeting(x, y, obj_piggydestroyable)
{
   instance_create(x, y, obj_explosion)
  
	   audio_play_sound(sfx_explosion, 100, 0)
   
   instance_destroy()
}
if sprite_index == spr_bomb && place_meeting(x+(hspeed), y-10, obj_piggy_bounceblock) && touched == 0
{
	hspeed *= -1
	
	touched = 1
}
if sprite_index == spr_bomb && !place_meeting(x+(hspeed), y-10, obj_piggy_bounceblock) && touched == 1
{
	
	touched = 0
}