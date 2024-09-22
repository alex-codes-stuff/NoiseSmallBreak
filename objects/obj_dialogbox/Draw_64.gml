/// @description Insert description here
// You can write your code in this editor\
if (draw == true)
{
	draw_set_color(c_black)
	draw_set_alpha(0.7)
	
	draw_rectangle(200, 530, (1080-width), 750, false)
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_set_font(Font3)
	if (width == 0)
		draw_text_ext(220, 540, text, 30, 860)
}

