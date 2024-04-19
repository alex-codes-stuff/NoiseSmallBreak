/// @description Insert description here
// You can write your code in this editor
with obj_player
{
	if sprite_index = spr_player_clocktowerintro2 && floor(image_index) = image_number - 1
	{
		image_index = 0
		sprite_index = spr_player_clocktowerintro3
		
	}
}
if ended == 1
{
	if radius < 800
	   radius += 30
    else
	    instance_destroy()
}
else if radius < 130
{
	radius += 5
}



