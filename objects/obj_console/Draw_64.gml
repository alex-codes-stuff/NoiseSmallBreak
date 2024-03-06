/// @description Drawing console
//Feather disable GM1019
#region Align functions (draw_set_align and draw_get_align)
function draw_set_align(halign, valign)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function draw_get_align()
{
	return [draw_get_halign(), draw_get_valign()]
}
#endregion

if (con.open)
{
	#region init
	draw_sprite_ext(con.screenshot, 0, 0, 0, 1 * (con.guisize[0] / con.game_guisize[0]), 1 * (con.guisize[1] / con.game_guisize[1]), 0, c_white, 1);
	var prevfnt = draw_get_font();
	draw_set_font(fnt_console);
	#endregion
	#region rect and top text
	// Rectangle
	draw_set_color(con.ui.background.color);
	draw_set_alpha(con.ui.background.opacity);
	draw_rectangle(0, 0, con.guisize[0], con.guisize[1], false);
	draw_set_color(c_white);
	
	// Text
	draw_set_align(fa_left, fa_top);
	draw_set_color(con.ui.text.colors.def);
	// Feather disable once GM1100
	// Feather disable once GM1063
	draw_text(0, 0, $"{con.strings.game} {con.strings.top.console} v{con.version} {con.strings.top.on} {con.strings.game} v{con.strings.game_version}{!con.build.release ? $"+{con.strings.build.test}" : ""}");
	draw_text(0, string_height("a"), $"{con.strings.top.gm} v{GM_runtime_version}"); // Console font is monospace so any character will be the same height
	draw_set_halign(fa_right);
	var build_date_txt = $"{con.strings.top.builddate} {date_datetime_string(GM_build_date)}";
	var build_type_txt = (con.build.release ? (con.build.compiled ? con.strings.build.compiled : con.strings.build.release) : con.strings.build.test);
	build_type_txt += $" {con.strings.build.build}"
	var build_type_clr = (con.build.release ? (con.build.compiled ? c_green : c_white) : c_red);
	draw_text(con.guisize[0], 0, build_date_txt);
	draw_set_color(build_type_clr);
	draw_text(con.guisize[0], string_height("a"), build_type_txt);
	// End (Cleanup)
	draw_set_color(con.ui.separator.col);
	draw_set_alpha(con.ui.separator.opacity);
	var _h = string_height("a\na") + con.ui.separator.width;
	draw_line_width(0, _h, con.guisize[0], _h, con.ui.separator.width);
	draw_set_alpha(con.ui.separator.opacity);
	#endregion
	#region console output
	draw_set_alpha(con.ui.text.output.opacity);
	var _ypos = string_height("a\na") + 8 + con.ui.separator.width;
	draw_set_font(fnt_console_small);
	var _startat = 0;
	var _lnsize = string_height("a")
	// If trim bug is fixed, init _lines as 0.
	var _lines = ds_list_size(con.output);
	
	#region Trim bug
	/* 
	This following code needs to trim the text so that
	it only removes extra lines and not the entire thing.
	If you wanna take the time out of your day to fix
	this, then do it, for now I'm commenting it out.
	*/
	/*
	for (var i = 0; i < ds_list_size(con.output); i++)
	{
		var _txt = con.output[| i][2]
		if (string_width(_txt) >= con.guisize[0])
		{
			for (var j = string_length(_txt); j > 0; i--)
			{
				var _newtxt = _txt;
				if (string_width(string_copy(_txt, 1, j)) <= con.guisize[0])
				{
					_newtxt = $"{string_copy(_txt, 1, j)}\n{string_copy(_txt, j, string_length(_txt))}"
				}
				_txt = _newtxt;
			}	
		}
		
		var _item_lines = array_length(string_split(_txt, "\n"))
		_lines += _item_lines
		
	}
	*/
	#endregion
	while ((_ypos + (_lnsize * _lines) - (_startat * _lnsize)) > con.guisize[1] - _lnsize * 2)
	{
		_startat++;
	}
	for (var i = _startat; i < ds_list_size(con.output); i++)
	{
		// TYPE - DATE - TEXT
		var _arr = con.output[| i];
		var _col = con.ui.text.colors.def;
		var _formatted = ""; // Formatted string
		var _type_fmt = ""; // Formatted type
		var _type_txt = ""; // Formatted type to show
		switch (_arr[0])
		{
			case (con.enums.logtype.log):
				_col = con.ui.text.output.colors.log;
				_type_fmt = con.strings.output.log;
			break;
			
			case (con.enums.logtype.warn):
				_col = con.ui.text.output.colors.warn;
				_type_fmt = con.strings.output.warn;
			break;
			
			case (con.enums.logtype.error):
				_col = con.ui.text.output.colors.error;
				_type_fmt = con.strings.output.error;
			break;
			
			case (con.enums.logtype.debug):
				_col = con.ui.text.output.colors.debug;
				_type_fmt = con.strings.output.debug;
			break;
		}
		draw_set_color(_col);
		if (_arr[0] != con.enums.logtype.none)
		{
			_type_txt = $"{_type_fmt} - "
		}
		_formatted = $"[{date_time_string(_arr[1])}] {_type_txt}{_arr[2]}";
		draw_set_align(fa_left, fa_top);
		draw_text(0, _ypos, _formatted);
		_ypos += string_height(_formatted);
	}
	#endregion
	#region cmdbar
	draw_set_color(con.ui.separator.col);
	draw_set_alpha(con.ui.separator.opacity);
	draw_set_font(fnt_console);
	_h = con.guisize[1] - string_height("a\na") + con.ui.separator.width;
	draw_line_width(0, _h, con.guisize[0], _h, con.ui.separator.width);
	draw_set_align(fa_left, fa_bottom);
	draw_set_color(con.ui.text.colors.def);
	draw_set_alpha(keyboard_string == "" ? con.ui.cmdbar.opacity_empty : con.ui.cmdbar.opacity);
	draw_text(0, con.guisize[1] - 4, $">{keyboard_string}");
	// Input bar
	draw_set_alpha(con.ui.cmdbar.input_bar.opacity);
	// We add 1 extra character because of the ">"
	draw_line_width(string_width($"{keyboard_string}a") + con.ui.cmdbar.input_bar.width, con.guisize[1] - 8, string_width($"{keyboard_string}a") + con.ui.cmdbar.input_bar.width, con.guisize[1] - 8 - string_height("a"), con.ui.cmdbar.input_bar.width);
	#endregion
	#region deinit
	draw_set_font(prevfnt);
	draw_set_color(c_white);
	draw_set_align(fa_left, fa_top);
	draw_set_alpha(1);
	#endregion
}
