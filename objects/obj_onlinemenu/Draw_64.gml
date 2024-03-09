/// @description Parallax & menu

#region parallax
// We're doing this with a sprite for the people with low/mid end pcs
// At the same time this would have made 9216*4 rects per frame
// (1280 / 10) * (720 / 10) * 4 at 10px per rect
if (global.performance)
{
	// Single sprite for performance mode
	var spr = [parallax.spr, parallax.index];
	draw_sprite(spr[0], spr[1], 0, 0);
	parallax.index++;
	parallax.index %= 11;
}
else
{
	if (parallax.visible)
	{
		var gw = display_get_gui_width();
		var gh = display_get_gui_height(); // GH More like GitHub amirite
		var spr = [parallax.spr, parallax.index];
		draw_sprite(spr[0], spr[1], parallax.x, parallax.y);
		draw_sprite(spr[0], spr[1], parallax.x - gw, parallax.y);
		draw_sprite(spr[0], spr[1], parallax.x, parallax.y + gh);
		draw_sprite(spr[0], spr[1], parallax.x - gw, parallax.y + gh);
		parallax.x += floor(parallax.speed);
		parallax.y -= floor(parallax.speed); //TODO: FIX Y, commented for now
		if (parallax.x >= display_get_gui_width())
			parallax.x = 0;
		if (parallax.y <= -display_get_gui_height())
			parallax.y = 0;
	}
}
#endregion

#region menu

for (var i = 0; i < struct_names_count(buttons); i++)
{
	var _btn = buttons[$ struct_get_names(buttons)[i]];
	
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
	draw_text(_middle[0], _middle[1], _btn.text);
	
	draw_set_halign(_oldalign[0]);
	draw_set_valign(_oldalign[1]);
}

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