live_auto_call;
var _cheesebehind = 0
if sin(cheese_thing) > 0
{
	_cheesebehind = 1
}
if !(_cheesebehind)
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale * xscale, image_yscale * yscale, image_angle, image_blend, image_alpha);
draw_set_font(fnt_console_small)
draw_set_color(c_white)
if !(_cheesebehind)
	if tnt
		draw_sprite(spr_hotwing, 0, x + cos(cheese_thing)*50, y + 10 + sin(cheese_thing) * 8)
	
if _cheesebehind
{
	if tnt
		draw_sprite(spr_hotwing, 0, x + cos(cheese_thing)*50, y + 10 + sin(cheese_thing) * 8)
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale * xscale, image_yscale * yscale, image_angle, image_blend, image_alpha);
}

//draw_text(x, y - 150, key_down2);
if atepig
	draw_text(x, y - 50,  pigtimer)

//gamepad_button_check(0, gp_shoulderrb)



