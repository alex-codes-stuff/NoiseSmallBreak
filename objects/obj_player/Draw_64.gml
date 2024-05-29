live_auto_call;

if !hp <= 0 && !(room == room_editor && global.play == 0) && room != room_minimenu && room != hub_1
{
for(var i = 0; i < max(hp, 4); i++)
	draw_sprite_ext(spr_healthHUD, 0, 32 + 78 * i, 16, 1, 1, 0, i >= hp ? c_black : c_white, 1);
draw_healthbar(32, 112, 288, 128, (movespeed / 19) * 100, c_black, c_blue, c_red, 0, true, true);
draw_healthbar(32, 112 + 50, 288, 128 + 50, (global.collect / 30) * 100, c_black, c_orange, c_red, 0, true, true);
draw_set_font(fnt_console_big)
if global.timeattack
{
if global.level == "junkbeach"
{
if timer >= 50
   draw_set_color(c_red)
}
else
   if timer >= 160
   draw_set_color(c_red)
}

if timerend == 1
   draw_set_color(c_green)
draw_text(640, 10, timer);
draw_set_color(c_white)
draw_set_font(collectfont)
//draw_text(150, 145, global.points);
draw_text(150, 150, string(global.collect) + "/30");
//draw_sprite_ext(spr_teacup,0, 32 + (78 * (hp +1)), 16, 1.2, 1.2, image_angle, image_blend, 1)
if global.timeattack
{
	draw_set_font(fnt_console_big)
	draw_text(1100, 0, "TIME ATTACK");
	
}
}