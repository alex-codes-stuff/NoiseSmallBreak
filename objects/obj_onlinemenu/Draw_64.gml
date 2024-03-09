/// @description bg & menu

#region bg
// We're doing this with a sprite for the people with low/mid end pcs
// At the same time this would have made 9216*4 rects per frame
// (1280 / 10) * (720 / 10) * 4 at 10px per rect
if (bg.visible)
{
	if (global.performance)
	{
		// Single sprite for performance mode
		var spr = [bg.spr, bg.index];
		draw_sprite(spr[0], spr[1], 0, 0);
		bg.index++;
		bg.index %= 11;
	}
	else
	{
		var gw = display_get_gui_width();
		var gh = display_get_gui_height(); // GH More like GitHub amirite
		var spr = [bg.spr, bg.index];
		draw_sprite(spr[0], spr[1], bg.x, bg.y);
		draw_sprite(spr[0], spr[1], bg.x - gw, bg.y);
		draw_sprite(spr[0], spr[1], bg.x, bg.y + gh);
		draw_sprite(spr[0], spr[1], bg.x - gw, bg.y + gh);
		bg.x += floor(bg.speed);
		bg.y -= floor(bg.speed); //TODO: FIX Y, commented for now
		if (bg.x >= display_get_gui_width())
			bg.x = 0;
		if (bg.y <= -display_get_gui_height())
			bg.y = 0;
	}
}
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_white);
draw_set_alpha(1);
#endregion

#region menu

for (var i = 0; i < struct_names_count(buttons.metas); i++)
{
	var _btn = buttons.metas[$ struct_get_names(buttons.metas)[i]];
	
	var _offset = btn_get_offset(_btn);
	
	var _pos = [_btn.x - _offset[0], _btn.y - _offset[1], _btn.x - _offset[0] + _btn.width, _btn.y - _offset[1] + _btn.height];
	var _c = _btn.color[0];
	draw_rectangle_color(_pos[0], _pos[1], _pos[2], _pos[3], _c, _c ,_c, _c, false);
	_c = _btn.color[1];
	if (_btn.outline) { draw_rectangle_color(_pos[0], _pos[1], _pos[2], _pos[3], _c, _c, _c, _c, true); }
	//var _middle = [_btn.x + _btn.width / 2, _btn.y + _btn.width / 2];
	var _middle = [_btn.x, _btn.y]
	var _oldalign = [draw_get_halign(), draw_get_valign()] // Just in case
	draw_set_halign(_btn.halign);
	draw_set_valign(_btn.valign);
	var _ofnt = draw_get_font();
	if (_btn.input_box[0] == true)
	{
		var _condition = (_btn.input_box[2] == "" && (is_undefined(selected_textbox) ? true : selected_textbox.meta.name != _btn.name));
		var _txt = (_btn.input_box[2] == "" ? _btn.text : _btn.input_box[2])
		var _col = (_btn.input_box[2] == "" ? c_gray : _btn.color[1]);
		draw_set_color(_col); 
		draw_set_font(_btn.input_box[1]);
		draw_text(_middle[0], _middle[1], _txt);
	}
	else { draw_text(_middle[0], _middle[1], _btn.text); }
	
	draw_set_color(c_white);
	draw_set_font(_ofnt);
	draw_set_halign(_oldalign[0]);
	draw_set_valign(_oldalign[1]);
}

#endregion

#region THE ONLY HARDCODED THING IN THE DRAW EVENT
draw_line_color(818, 0, 818, display_get_gui_height(), c_white, c_white); // Too lazy!
#endregion

#region popup
if (popup.show)
{
	var _popup = popup;
	
	var _fakebtn = {halign: fa_center, valign: fa_middle, width: _popup.width, height: _popup.height} // For the btn_get_offset func
	var _offset = btn_get_offset(_fakebtn);
	var _dpos = [display_get_gui_width() / 2, display_get_gui_height() / 2]; // Display pos / 2
	var _pos = [_dpos[0] - _offset[0], _dpos[1] - _offset[1], _dpos[0] - _offset[0] + _popup.width, _dpos[1] - _offset[1] + _popup.height];
	var _c = c_black;
	draw_rectangle_color(_pos[0], _pos[1], _pos[2], _pos[3], _c, _c, _c, _c, false);
	_c = c_white;
	draw_rectangle_color(_pos[0], _pos[1], _pos[2], _pos[3], _c, _c, _c, _c, true);
	
	// Is it fine to copy paste if it's your own code
	var _middle = [_dpos[0], _dpos[1]]
	var _oldalign = [draw_get_halign(), draw_get_valign()] // Just in case
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_middle[0], _middle[1], _popup.text);
	
	draw_set_halign(_oldalign[0]);
	draw_set_valign(_oldalign[1]);
}
#endregion