live_auto_call;

draw_sprite_ext(sprite_index, -1, x, y, image_xscale * xscale, image_yscale * yscale, image_angle, image_blend, image_alpha);
draw_set_font(fnt_console_small)
draw_set_color(c_white)
draw_text(x-10, y - 60, movespeed);
//draw_text(x, y - 100, vsp);
//draw_text(x, y - 150, _move);
// draw_text(x, y - 200,  hp)

//gamepad_button_check(0, gp_shoulderrb)



