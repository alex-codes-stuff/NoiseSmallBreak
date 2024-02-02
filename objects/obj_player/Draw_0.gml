live_auto_call;

draw_sprite_ext(sprite_index, -1, x, y, image_xscale * xscale, image_yscale * yscale, image_angle, image_blend, image_alpha);
draw_set_font(fnt_caption)
draw_set_color(c_white)
draw_text(x, y - 50, movespeed);
draw_text(x, y - 100, tnt);
draw_text(x, y - 150, _move);
draw_text(x, y - 200, gamepad_button_check(0, gp_shoulderrb) * xscale);

//gamepad_button_check(0, gp_shoulderrb)



