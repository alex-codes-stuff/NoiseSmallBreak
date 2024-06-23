/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_console)
draw_set_color(c_black)
#region bg
if (bg.visible)
{
	if (global.performance)
	{
		// Single sprite for performance mode
		var spr = [bg.spr, bg.index];
		draw_sprite_ext(spr[0], spr[1], 0, 0, 1, 1, 90, c_white, image_alpha);
		bg.index++;
		bg.index %= 11;
	}
	else
	{
		var gw = display_get_gui_width();
		var gh = display_get_gui_height(); // GH More like GitHub amirite
		var spr = [bg.spr, bg.index];
		draw_sprite_ext(spr[0], spr[1], bg.x, bg.y, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x - gw, bg.y, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x, bg.y + gh, 1, 1, 90, c_white, image_alpha);
		draw_sprite_ext(spr[0], spr[1], bg.x - gw, bg.y + gh, 1, 1, 90, c_white, image_alpha);
		bg.x += floor(bg.speed);
		bg.y -= floor(bg.speed); //TODO: FIX Y, commented for now
		if (bg.x >= display_get_gui_width())
			bg.x = 0;
		if (bg.y <= -display_get_gui_height())
			bg.y = 0;
	}
}

draw_set_alpha(0.75);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);
#endregion
draw_text_ext(0, 0, changelog, 20, 1280)

