live_auto_call;

if !hp <= 0 && !(room == room_editor && global.play == 0) && !instance_exists(obj_pausemenu) && room != hub_1 && room != rm_changelog
{
	for(var i = 0; i < max(hp, 4); i++)
	{	
		var _y = (sin(sintimer+i)*5)-5
		draw_sprite_ext(spr_health_indicators, i, 55 + 78 * i, _y, 1, 1, 0, i >= hp ? c_black : c_white, 1)
	};
	
	//draw_healthbar(32, 112, 288, 144, (movespeed / 13) * 100, c_purple, c_purple, c_purple, 0, false, false);
	
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);
	draw_set_alpha(0);
	draw_rectangle(0,0, room_width,room_height, false);
	
	draw_set_alpha(1);
	draw_healthbar(19, 124, 310, 158, (movespeed / 13) * 100, c_white, c_white, c_white, 0, false, false);
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
	
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	gpu_set_alphatestenable(true);
	draw_sprite(spr_speedbar_fill, 0, 192, 128);
	gpu_set_alphatestenable(false);
	gpu_set_blendmode(bm_normal);
	
	draw_sprite(spr_speedbar_bar, 0, 192, 128)
	
	var _sprite = spr_player_idle
	var _noiseicon_x = (movespeed / 13) * 256
	if _noiseicon_x > 256
	   _noiseicon_x = 256
	if lasthealthbar_x < _noiseicon_x
		_sprite = spr_player_mach3
	if lasthealthbar_x > _noiseicon_x
		_sprite = spr_player_crouchslip
	if lasthealthbar_x == _noiseicon_x && _noiseicon_x != 0
		_sprite = spr_player_mach3
	else if _noiseicon_x == 0
		_sprite = spr_player_idle
	lasthealthbar_x = _noiseicon_x
	draw_sprite(_sprite, noiseicon_speed, 32 + _noiseicon_x, 112)
	draw_sprite(spr_teacup, 0, 128+42, 152)
	draw_set_font(fnt_console_big)
	draw_set_color(c_white)
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
	draw_set_halign(fa_center)
	draw_text(150+20, 185, string(global.collect) + "/20");
	draw_set_halign(fa_left)
	//draw_sprite_ext(spr_teacup,0, 32 + (78 * (hp +1)), 16, 1.2, 1.2, image_angle, image_blend, 1)

}
if global.timeattack
{
	draw_set_font(fnt_console_big)
	draw_text(1100, 0, "TIME ATTACK");
	
}
if controllerConnected
{
	draw_set_font(fnt_console_big)
	draw_text(1040, 690, "CONTROLLER CONNECTED");
	
}