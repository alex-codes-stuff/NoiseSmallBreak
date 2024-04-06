/// @description Insert description here
// You can write your code in this editor
draw_self()

if open == 1
{
	var sprites = ["spr_wall", "spr_slope", "spr_eggopp_idle", "spr_convexslope", "spr_collect", "spr_destroyable", "spr_shuttle", "spr_doorC", "spr_doorB", "spr_plug", "spr_hallway"]
	for (var i = 0; i < array_length(sprites); i++)
	{
		draw_set_color(c_black)
		if (i != 10)
		{
			draw_rectangle(x, y+50+64*i, xx, yy+64*i, false)
			draw_set_color(c_white)
			draw_rectangle(x, y+50+64*i, xx, yy+64*i, true)
		}
		else
		{
			draw_rectangle(x+64, y+50+64*(i-1), xx+64, yy+64*(i-1), false)
			draw_set_color(c_white)
			draw_rectangle(x+64, y+50+64*(i-1), xx+64, yy+64*(i-1), true)
		}
		var _xscalesmall = 1
		var _yscalesmall = 1
		if sprite_get_width(asset_get_index(array_get(sprites, i))) > 64
		{
			_xscalesmall = 2
		}
		if sprite_get_height(asset_get_index(array_get(sprites, i))) > 64
		{
			_yscalesmall = 2
		}
		if (i != 10)
		{
			draw_sprite_ext(asset_get_index(array_get(sprites, i)),0,xx/2, yy/2+64*i, 1/_xscalesmall, 1/_yscalesmall, image_angle, image_blend, image_alpha)
		}
		else
		{
			draw_sprite_ext(asset_get_index(array_get(sprites, i)),0,xx/2+64, yy/2+64*(i-1), 1/_xscalesmall, 1/_yscalesmall, image_angle, image_blend, image_alpha)
		}
	}
	/*
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
	*/
	
}



