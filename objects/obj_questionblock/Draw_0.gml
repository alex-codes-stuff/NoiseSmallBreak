if hit == 0
   draw_self()
   
if hit == 1
{
	if wait > 0
	   draw_sprite(spr_questionmarkblock, 0, x, y-wait)
	else
	{
		draw_set_color(c_red)
	   draw_sprite(spr_questionmarkblock, 0, x, y-wait)
	   hit = 0
	}
}