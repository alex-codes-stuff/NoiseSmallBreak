 /// @description Insert description here
// You can write your code in this editor
draw_self()
//draw_text(x, y-50, place_meeting(x, y+2, obj_solid) || place_meeting(x, y+2, obj_platform))
if (thingy == 1 && state == 0)
{
	if !(about_to_detect)
		draw_sprite(spr_down, 0, x, y-120)
	else
		draw_sprite(spr_ctrlr, 0, x, y-120)
}


