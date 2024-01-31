live_auto_call;

for(var i = 0; i < max(hp, 4); i++)
	draw_sprite_ext(spr_healthHUD, 0, 32 + 78 * i, 16, 1, 1, 0, i >= hp ? c_black : c_white, 1);
draw_healthbar(32, 112, 288, 128, (movespeed / 19) * 100, c_black, c_blue, c_red, 0, true, true);
draw_healthbar(32, 112 + 50, 288, 128 + 50, (global.collect / 20) * 100, c_black, c_orange, c_red, 0, true, true);
draw_set_font(Font2)
if global.timeattack
{
if timer >= 40
   draw_set_color(c_red)
}
if timerend == 1
   draw_set_color(c_green)
draw_text(640, 10, timer);
draw_set_color(c_white)
draw_text(150, 145, global.points);
if global.timeattack
	draw_text(1100, 0, "TIME ATTACK");