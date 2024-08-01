/// @description Insert description here
// You can write your code in this editor
if insideView
{
	var _hsp = spd * dir
	
	vspd += grav
	
	
	if place_meeting(x+(_hsp), y+vspd, obj_solid)
	{
		var _pixelCheck = sign(vspd)
		while !place_meeting(x+(spd*dir), y+_pixelCheck, obj_solid)
		{
			y += _pixelCheck
		}
		
		vspd = 0
	}
	x += _hsp
	y += vspd
	
	if scr_solid(x + (spd*dir), y-10)
	   dir *= -1
}
if dead
{
   sprite_index = spr_goomba_dead
   spd = 0
}
else
   sprite_index = spr_goomba





