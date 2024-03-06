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
	var prevfnt = draw_get_font();
	draw_set_font(fnt_console);
	#endregion
	#region rect and top text
	// Rectangle
	draw_set_color(con.ui.background.color);
	draw_set_alpha(con.ui.background.opacity);
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false);
	draw_set_color(c_white);
	
	// Text
	draw_set_align(fa_left, fa_top);
	draw_set_color(con.ui.text.colors.def);
	draw_text(0, 0, $"NBB Console v{con.version} on NBB v{global.gamever}");
	draw_text(0, string_height("a"), $"GameMaker v{GM_runtime_version}"); // Console font is monospace so any character will be the same height
	draw_set_halign(fa_right);
	var build_date_txt = $"Build date {date_datetime_string(GM_build_date)}";
	var build_type_txt = (con.build.release ? (con.build.compiled ? "COMPILED/YYC BUILD" : "RELEASE BUILD") : "TEST BUILD");
	var build_type_clr = (con.build.release ? (con.build.compiled ? c_green : c_white) : c_red);
	draw_text(SCREEN_WIDTH, 0, build_date_txt);
	draw_set_color(build_type_clr);
	draw_text(SCREEN_WIDTH, string_height("a"), build_type_txt);
	// End (Cleanup)
	draw_set_color(con.ui.separator.col);
	draw_set_alpha(1);
	var _h = string_height("a\na") + con.ui.separator.width;
	draw_line_width(0, _h, SCREEN_WIDTH, _h, con.ui.separator.width);
	#endregion
	#region console output
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
		if (string_width(_txt) >= SCREEN_WIDTH)
		{
			for (var j = string_length(_txt); j > 0; i--)
			{
				var _newtxt = _txt;
				if (string_width(string_copy(_txt, 1, j)) <= SCREEN_WIDTH)
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
	while ((_ypos + (_lnsize * _lines) - (_startat * _lnsize)) > SCREEN_HEIGHT - _lnsize * 2)
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
				_col = con.ui.text.colors.log;
				_type_fmt = "log";
			break;
			
			case (con.enums.logtype.warn):
				_col = con.ui.text.colors.warn;
				_type_fmt = "warn";
			break;
			
			case (con.enums.logtype.error):
				_col = con.ui.text.colors.error;
				_type_fmt = "error"
			break;
			
			case (con.enums.logtype.debug):
				_col = con.ui.text.colors.debug;
				_type_fmt = "debug"
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
	draw_set_font(fnt_console);
	var _h = SCREEN_HEIGHT - string_height("a\na") + con.ui.separator.width;
	draw_line_width(0, _h, SCREEN_WIDTH, _h, con.ui.separator.width);
	draw_set_align(fa_left, fa_bottom);
	draw_set_color(con.ui.text.colors.def);
	draw_set_alpha(keyboard_string == "" ? 0.5 : 1);
	draw_text(0, SCREEN_HEIGHT - 4, $">{keyboard_string}");
	#endregion
	#region deinit
	draw_set_font(prevfnt);
	draw_set_color(c_white);
	draw_set_align(fa_left, fa_top);
	#endregion
}