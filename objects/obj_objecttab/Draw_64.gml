/// @description Insert description here
// You can write your code in this editor
draw_self()

if open == 1
{
	thingy = 0
	draw_set_color(c_black)
	draw_rectangle(x, y+50, xx, yy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50, xx, yy, true)
	draw_sprite(spr_wall,0,xx/2, yy/2)
  thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_slope,0,xx/2, yy/2+64*thingy)
	 thingy += 1	
	draw_set_color(c_black)
	draw_rectangle(x, y+50+128, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_eggopp_idle,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_convexslope,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_collect,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_destroyable,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite_ext(spr_shuttle,0,xx/2, yy/2+64*thingy+10, 0.5, 0.5, image_angle, image_blend, image_alpha)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_doorC,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_doorB,0,xx/2, yy/2+64*thingy)
	 thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x, y+50+64*thingy, xx, yy+64*thingy, true)
	draw_sprite(spr_plug,0,xx/2, yy/2+64*thingy)
	// thingy += 1
	draw_set_color(c_black)
	draw_rectangle(x+64, y+50+64*thingy, xx+64, yy+64*thingy, false)
	draw_set_color(c_white)
	draw_rectangle(x+64, y+50+64*thingy, xx+64, yy+64*thingy, true)
	draw_sprite(spr_hallway,0,xx/2+64, yy/2+64*thingy)
	
}



