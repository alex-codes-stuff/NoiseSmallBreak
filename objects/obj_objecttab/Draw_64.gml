/// @description Insert description here
// You can write your code in this editor
draw_self()

if open == 1
{
	
	draw_set_color(c_black)
	draw_rectangle(x, y+50, xx, yy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50, xx, yy, true)
	draw_sprite(spr_wall,0,xx/2, yy/2)
	
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64, xx, yy+64, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64, xx, yy+64, true)
	draw_sprite(spr_slope,0,xx/2, yy/2+64)
	
	draw_set_color(c_black)
	draw_rectangle(x, y+50+128, xx, yy+64*2, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*2, xx, yy+64*2, true)
	draw_sprite(spr_eggopp_idle,0,xx/2, yy/2+64*2)
	
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*3, xx, yy+64*3, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*3, xx, yy+64*3, true)
	draw_sprite(spr_convexslope,0,xx/2, yy/2+64*3)
	
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*4, xx, yy+64*4, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*4, xx, yy+64*4, true)
	draw_sprite(spr_collect,0,xx/2, yy/2+64*4)
	
}



