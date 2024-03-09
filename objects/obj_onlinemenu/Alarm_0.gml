/// @description Call UI functions

btn_add(new ButtonMeta("lvlsearch", "Type your search here...", 275, 35, 500, 50, true, [c_black, c_white], fa_center, fa_middle, [true, Font3, false, 0]), 
function (_input)
{
	var _txt = "TODO";
	show_popup(_txt);
	
	return false;
});


btn_add(new ButtonMeta("nickname", "Enter your nickname...", 695, 35, 320, 50, true, [c_black, c_white], fa_center, fa_middle, [true, Font3, false, 16]),
function (_input)
{
	//var _in = string_replace_all(_input, " ", "");
	//var _is_valid = nickname_check_func(_input);
	var _in_check = _input;
	var _is_valid = [true, ""];
	// Imma be honest I stole this from PTT 
	var _replacements = [["0", "o"], ["1", "i"], ["!", "i"], ["3", "e"], ["4", "a"], ["@", "a"], ["5", "s"], ["7", "t"], ["8", "b"], ["ph", "f"], ["nn", "n"], ["gg", "g"]];
	for (var i = 0; i < array_length(_replacements); i++)
	{
		var _replace = _replacements[i][0];
		var _to = _replacements[i][1];
		
		_in_check = string_replace_all(_in_check, _replace, _to);
	}
	var _utmt_mfs = "Imma be honest I stole this from PTT"; // Being honest to the utmt mfs
	// Sorry for all the nigerians but I gotta block the hard r
	var _filter = ["niga", "niger", "fag", "fagot", "trani", "hermafrodite", "shemale", "heshe", "kill", "murder", "black", "jew", "trans"];
	
	for (var i = 0; i < array_length(_filter); i++)
	{
		if (_in_check == _filter[i]) { _is_valid = [false, "Detected as inappropriate"]; }
	}
	
	if (string_length(_input) > 16) { _is_valid = [false, "Over 16 characters"]; }
	
	
	if (!_is_valid[0])
	{
		show_popup(_is_valid[1]);
		return;
	}
	else
	{
		nickname = _input;
	}
},
function(_btn)
{
	_btn.meta.text = nickname;
},
function(_btn, _txt)
{
	var _newtxt = string_replace_all(_txt, " ", ""); // Remove spaces
	var _checktxt = _newtxt;
	var _is_valid = [true, ""];
	// Imma be honest I stole this from PTT 
	var _replacements = [["0", "o"], ["1", "i"], ["!", "i"], ["3", "e"], ["4", "a"], ["@", "a"], ["5", "s"], ["7", "t"], ["8", "b"], ["ph", "f"], ["nn", "n"], ["gg", "g"]];
	for (var i = 0; i < array_length(_replacements); i++)
	{
		var _replace = _replacements[i][0];
		var _to = _replacements[i][1];
		
		_checktxt = string_replace_all(_newtxt, _replace, _to);
	}
	var _utmt_mfs = "Imma be honest I stole this from PTT"; // Being honest to the utmt mfs
	// Sorry for all the nigerians but I gotta block the hard r
	var _filter = ["niga", "niger", "fag", "fagot", "trani", "hermafrodite", "shemale", "heshe", "kill", "murder", "black", "jew"];//, "trans"];
	
	for (var i = 0; i < array_length(_filter); i++)
	{
		if (_checktxt == _filter[i]) { _is_valid = [false, "Detected as inappropriate"]; }
	}
	
	if (string_length(_newtxt) < 3) { _is_valid = [false, "Username must be at least 3 characters."]; }
	
	//if (string_length(_newtxt) > 16) { _is_valid = [false, "Over 16 characters"]; }
	//_btn.meta.color[1] = (_is_valid[0] ? c_white : c_red);
	if (_is_valid[0])
	{
		var _special_names = ["Luz"]; // Luz easter eggsg,fdhtryf,dvgc AND SOME OTHERS LATER
		var _is_special = array_contains(_special_names, _newtxt);
		_btn.meta.color[1] = (_is_special ? c_yellow : c_white); // :3
	}
	else
	{
		_btn.meta.color[1] = c_red;
	}
	
	for (var i = string_length(_newtxt); i > 0; i--) // Filter stuff
	{
		show_debug_message($"Checking char {i}");
		// My code is so bad that it looks obfuscated at a glance :sob:
		var _ok = [[48, 57], [65, 90], 95, [97, 122]]; // THIS ARRAY IS INCLUSIVE
		// Check ascii table if you wanna add values
		var _byte = string_byte_at(_newtxt, i);
		var _pass = false;
		for (var j = 0; j < array_length(_ok); j++)
		{
			var _value = _ok[j];
			switch (is_array(_value)) // Switching things up for once
			{
				case true:
					if (_byte >= _value[0] && _byte <= _value[1])
					{
						show_debug_message($"Passed range {string_join_ext("-", _value)}, byte is {_byte}");
						_pass = true;
						break;
					}
				break;
				
				case false:
					if (_byte == _value)
					{
						show_debug_message($"Passed individual char {_value}, byte is {_byte}");
						_pass = true;
						break;
					}
				break;
			}
		}
		
		if (!_pass)
		{
			show_debug_message($"Not pass, deleting char {i}");
			_newtxt = string_delete(_newtxt, i, 1); // string_delete() arg 2 starts from 1
		}
	}
	
	//return string_replace_all(_txt, " ", "");
	return _newtxt;
});