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
#region Draw funcs
/// @param {Array}	_arr
/// @returns {String}
function format_log(_arr)
{
	var _type_fmt = ""; // Formatted type
	var _type_txt = ""; // Formatted type to show
	var _time_txt = ""; // Formatted [XX:XX:XX AM/PM] text
	//TODO: Turn this into a function
	switch (_arr[0])
	{
		case (con.enums.logtype.log):
			_type_fmt = con.strings.output.log;
		break;
		
		case (con.enums.logtype.warn):
			_type_fmt = con.strings.output.warn;
		break;
		
		case (con.enums.logtype.error):
			_type_fmt = con.strings.output.error;
		break;
		
		case (con.enums.logtype.debug):
			_type_fmt = con.strings.output.debug;
		break;
	}
	if (_arr[0] != con.enums.logtype.none && _arr[3])
	{
		_type_txt = $"{_type_fmt} - "
	}
	_time_txt = (_arr[1] != -1 ? $"[{date_time_string(_arr[1])}] " : "")
	return $"{_time_txt}{_type_txt}{_arr[2]}";
	
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
	
	var _outdated_txt = con.strings.outdated[$ con_enum_get_name("outdated", con.outdated)];
	// Feather disable once GM1100
	// Feather disable once GM1063
	var _gameinfo_txt = $"{con.strings.top.console} v{con.version} | {con.strings.top.updstatus} ";
	draw_text(0, 0, _gameinfo_txt);
	var _outdated_clr = con.ui.top.colors.outdated[$ con_enum_get_name("outdated", con.outdated)];
	draw_set_color(_outdated_clr);
	draw_text(string_width(_gameinfo_txt), 0, _outdated_txt);
	draw_set_color(con.ui.text.colors.def);
	draw_text(0, string_height("M"), $"{con.strings.top.gm} v{GM_runtime_version}"); // Console font is monospace so any character will be the same height
	draw_set_halign(fa_right);
	
	var _build_date_txt = $"{con.strings.top.builddate} {date_datetime_string(GM_build_date)}";
	var _build_type_txt = (con.build.release ? (con.build.compiled ? con.strings.build.compiled : con.strings.build.release) : con.strings.build.test);
	_build_type_txt += $" {con.strings.build.build}"
	var _build_type_clr = (con.build.release ? (con.build.compiled ? c_green : c_white) : c_red);
	
	draw_text(con.guisize[0], 0, _build_date_txt);
	draw_set_color(_build_type_clr);
	draw_text(con.guisize[0], string_height("M"), _build_type_txt);
	// End (Cleanup)
	draw_set_color(con.ui.separator.col);
	draw_set_alpha(con.ui.separator.opacity);
	
	var _h = string_height("M\nM") + con.ui.separator.width;
	
	draw_line_width(0, _h, con.guisize[0], _h, con.ui.separator.width);
	draw_set_alpha(con.ui.separator.opacity);
	#endregion
	#region console output
	
	draw_set_alpha(con.ui.text.output.opacity);
	var _ypos = string_height("M\nM") + 8 + con.ui.separator.width;
	draw_set_font(fnt_console_small);
	var _startat = 0;
	var _lnsize = string_height("M")
	var _conout = con.output;
	var _rmlist = [];
	#region filtering
	if (!con.settings.show_debug_logs)
	{
		for (var i = 0; i < ds_list_size(con.output); i++)
		{
			if (con.output[| i][0] == con.enums.logtype.debug)
			{
				array_push(_rmlist, i);
			}
		}
	}
	for (var i = array_length(_rmlist) - 1; i >= 0; i--) // Reverse order because else we would need to offset every deletion
	{
		ds_list_delete(_conout, _rmlist[i]);
	}
	#endregion
	#region half-assed word wrap
	for (var i = 0; i < ds_list_size(_conout); i++)
	{
		var _arr = _conout[| i];
		// Feather disable once GM1041
		var _extrawidth = ((_arr[0] != con.enums.logtype.none && _arr[3]) ? string_width(format_log([_arr[0], _arr[1], "", _arr[3]])) : 0);
		var _totalchar = 1;
		var _char = 1;
		var _widthrm = 0;
		var _str_to_wrap = _arr[2];
		while (string_length(_arr[2]) >= _totalchar)
		{
			if (_extrawidth + string_width(string_copy(_str_to_wrap, 1, _char)) - (_widthrm * con.guisize[0]) >= con.guisize[0])
			{
				_arr[2] = $"{string_copy(_arr[2], 1, _char - 1)}\n{string_copy(_arr[2], _char, string_length(_arr[2]))}";
				_str_to_wrap = string_copy(_arr[2], _totalchar, string_length(_arr[2]));
				_widthrm++;
				_char = 0;
			}
			_char++;
			_totalchar++;
		}
	}
	#endregion
	#region Newline handling
	var _newlist = ds_list_create();
	for (var i = 0; i < ds_list_size(_conout); i++)
	{
		var _arr = _conout[| i];
		// Feather disable once GM2016
		_arr[2] = string_replace_all(_arr[2], "\t", "    "); // Replace \t to 4 spaces
		var _curtext = _arr[2];
		var _newlines = string_split(_curtext, "\n");
		if (array_length(_newlines) > 1)
		{
			for (var j = 0; j < array_length(_newlines); j++)
			{
				//TODO: Optimize
				// FORMAT: TYPE - DATE - TEXT - SHOW_TYPE
				var _newarr = (j == 0 ? [_arr[0], _arr[1], _newlines[0], true] : [_arr[0], -1, _newlines[j], false])
				ds_list_add(_newlist, _newarr);
			}
		}
		else
		{
			ds_list_add(_newlist, _arr);
		}
	}
	_conout = _newlist;
	#endregion
	var _lines = ds_list_size(_conout);
	
	//TODO: HANDLE THIS MORE EFFICIENTLY
	while (((_lnsize * _lines) - (_startat * _lnsize)) > con.guisize[1] - _lnsize * 2 - con.ui.separator.width - _ypos) { _startat++; }
	
	for (var i = _startat; i < ds_list_size(_conout); i++)
	{
		// TYPE - DATE - TEXT
		var _arr = _conout[| i];
		var _col = con.ui.text.colors.def;
		var _formatted = format_log(_arr);
		switch (_arr[0])
		{
			case (con.enums.logtype.log):
				_col = con.ui.text.output.colors.log;
			break;
			
			case (con.enums.logtype.warn):
				_col = con.ui.text.output.colors.warn;
			break;
			
			case (con.enums.logtype.error):
				_col = con.ui.text.output.colors.error;
			break;
			
			case (con.enums.logtype.debug):
				_col = con.ui.text.output.colors.debug;
			break;
		}
		draw_set_align(fa_left, fa_top);
		draw_set_color(_col);
		draw_text(0, _ypos, _formatted);
		_ypos += string_height("M");
	}
	#endregion
	#region cmdbar
	draw_set_color(con.ui.separator.col);
	draw_set_alpha(con.ui.separator.opacity);
	draw_set_font(fnt_console);
	
	_h = con.guisize[1] - string_height("M\nM") + con.ui.separator.width;
	draw_line_width(0, _h, con.guisize[0], _h, con.ui.separator.width);
	draw_set_align(fa_left, fa_bottom);
	draw_set_color(con.ui.text.colors.def);
	draw_set_alpha(keyboard_string == "" ? con.ui.cmdbar.opacity_empty : con.ui.cmdbar.opacity);
	draw_text(0, con.guisize[1] - 4, $">{keyboard_string}");
	// Input bar
	draw_set_alpha(con.ui.cmdbar.input_bar.opacity);
	// We add 1 extra character because of the ">"
	draw_line_width(string_width($"{keyboard_string}M") + con.ui.cmdbar.input_bar.width, con.guisize[1] - 8, string_width($"{keyboard_string}M") + con.ui.cmdbar.input_bar.width, con.guisize[1] - 8 - string_height("M"), con.ui.cmdbar.input_bar.width);
	#endregion
	#region deinit
	draw_set_font(prevfnt);
	draw_set_color(c_white);
	draw_set_align(fa_left, fa_top);
	draw_set_alpha(1);
	#endregion
}
