/// @description Detect kliks, lik 3kliksphilip frfr ong

if (selected_textbox != undefined)
{
	if (!struct_exists(selected_textbox, "meta") || !struct_exists(selected_textbox, "func")) { var _msg = "Invalid input box was selected"; throw({message: _msg, longMessage: _msg, stacktrace: debug_get_callstack(), line: -1}); }
	if (is_undefined(selected_textbox[$ "meta"]) || is_undefined(selected_textbox[$ "func"])) { var _msg = "Invalid input box was selected"; throw({message: _msg, longMessage: _msg, stacktrace: debug_get_callstack(), line: -1}); } 
	var _meta = selected_textbox.meta;
	//selected_textbox.meta.input_box[2] = keyboard_string;
	var _changed = (_meta.input_box[2] != keyboard_string);
	
	_meta.input_box[2] = keyboard_string;
	var _ofnt = draw_get_font();
	//draw_set_font(selected_textbox.meta.input_box[1]);
	draw_set_font(_meta.input_box[1]);
	//var _cond = (string_width(selected_textbox.meta.input_box[2]) >= selected_textbox.meta.width);
	
	var _char_limit = _meta.input_box[4];
	//if (_meta.input_box[3] > 0) { _meta.input_box[2] = string_copy(_meta.input_box[2], 1, _meta.input_box[3]); } // Character limit
	if (_char_limit > 0 && string_length(_meta.input_box[2]) > _char_limit) // Character limit
	{
		var _newtxt = string_copy(_meta.input_box[2], 1, _char_limit);
		show_debug_message($"{_meta.input_box[2]} capped to {_char_limit} chars. New text: `{_newtxt}`");
		_meta.input_box[2] = _newtxt;
	}
	
	var _cond = (string_width(_meta.input_box[2]) >= _meta.width);
	if (_cond)
	{
		//for (var i = 1; i <= string_length(selected_textbox.meta.input_box[2]); i++)
		for (var i = 1; i <= string_length(_meta.input_box[2]); i++)
		{
			//var _str = string_copy(selected_textbox.meta.input_box[2], 1, i);
			var _str = string_copy(_meta.input_box[2], 1, i);
			//if (string_width(_str) < selected_textbox.meta.width) { continue; }
			if (string_width(_str) < _meta.width) { continue; }
			var _thingy = 1;
			while (_cond)
			{
				//selected_textbox.meta.input_box[2] = string_copy(selected_textbox.meta.input_box[2], 1, i - _thingy);
				_meta.input_box[2] = string_copy(_meta.input_box[2], 1, i - _thingy);
				_thingy++;
				//_cond = (string_width(selected_textbox.meta.input_box[2]) >= selected_textbox.meta.width);
				_cond = (string_width(_meta.input_box[2]) >= _meta.width);
				if (_thingy > 200)
				{
					show_debug_message("FAIL");
					break; // Failsafe
				}
			}
			//keyboard_string = selected_textbox.meta.input_box[2];
			keyboard_string = _meta.input_box[2];
			break;
		}
	}
	draw_set_font(_ofnt);
	
	if (!is_undefined(selected_textbox.changefunc) && _changed) 
	{
		var _ret = selected_textbox.changefunc(selected_textbox, _meta.input_box[2]);
		_meta.input_box[2] = _ret;
		keyboard_string = _ret;
	}
	
	if (keyboard_check_pressed(vk_enter) && _meta.input_box[2] != "")
	{
		var _txt = _meta.input_box[2];
		var _clear = selected_textbox.func(_txt);
		if (is_undefined(_clear)) { _clear = true; }
		if (_clear)
		{
			selected_textbox.meta.input_box[2] = "";
			keyboard_string = "";
		}
		if (!is_undefined(selected_textbox.callback)) { selected_textbox.callback(selected_textbox); }
	}
}


if (mouse_check_button_pressed(mb_left))
{
	if (!popup.show)
	{
		var _undefine_box = true;
		show_debug_message(struct_names_count(buttons.metas));
		for (var i = 0; i < struct_names_count(buttons.metas); i++)
		{
			var _btn = buttons.metas[$ struct_get_names(buttons.metas)[i]];
			
			var _mousepos = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
			var _check = [false, false];
			var _offset = btn_get_offset(_btn);
			if (_mousepos[0] >= _btn.x - _offset[0] && _mousepos[0] <= _btn.x - _offset[0] + _btn.width) {  _check[0] = true; }
			if (_mousepos[1] >= _btn.y - _offset[1] && _mousepos[1] <= _btn.y - _offset[1] + _btn.height) { _check[1] = true; }
			
			show_debug_message($"{_mousepos[0]} between {_btn.x - _offset[0]} and {_btn.x - _offset[0] + _btn.width}");
			show_debug_message($"{_mousepos[1]} between {_btn.y - _offset[1]} and {_btn.y - _offset[1] + _btn.height}");
			if (_check[0] && _check[1])
			{
				if (_btn.input_box[0])
				{
					prev_kbdstr = keyboard_string;
					keyboard_string = _btn.input_box[2];
					//selected_textbox = {meta: _btn, func: buttons.funcs[$ _btn.name]};
					selected_textbox = btn_get(_btn.name);
					_undefine_box = false;
					show_debug_message(selected_textbox);
				}
				else
				{
					show_debug_message($"Press: {_btn.name}");
					try
					{
						_btn.func();
						if (!is_undefined(_btn.callback)) { _btn.callback(_btn); }
					} 
					catch (_e)
					{
						var _msg = $"Exception pressing button {_btn.name}.";
						show_popup(_msg);
						show_debug_message($"{_msg}\n---\nDumping exception struct.\n{string(_e)}\n---");
					}
				}
			}
			else if (selected_textbox != undefined && _undefine_box)
			{
				selected_textbox = undefined;
				keyboard_string = prev_kbdstr;
			}
		}
	}
	else // popup
	{
		var _popup = popup;
		var _mousepos = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
		var _check = [false, false];
		var _fakebtn = {halign: fa_center, valign: fa_middle, width: _popup.width, height: _popup.height} // For the btn_get_offset func
		
		var _offset = btn_get_offset(_fakebtn);
		var _dpos = [display_get_gui_width() / 2, display_get_gui_height() / 2]; // Display pos / 2
		if (_mousepos[0] >= _dpos[0] - _offset[0] && _mousepos[0] <= _dpos[0] - _offset[0] + _popup.width) {  _check[0] = true; }
		if (_mousepos[1] >= _dpos[1] - _offset[1] && _mousepos[1] <= _dpos[1] - _offset[1] + _popup.height) { _check[1] = true; }
		
		if (_check[0] && _check[1]) { _popup.show = false; }
	}
}

for (var i = 0; i < struct_names_count(changequeue); i++)
{
	var _item = changequeue[$ struct_get_names(changequeue)[i]];
	
	if (_item[0] <= 0 && is_string(_item[1]))
	{
		buttons[$ struct_get_names(changequeue[i])].text = _item[1];
		struct_remove(changequeue, _item);
	}
}

if (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_face1)) 
{
	with (instance_create_depth(obj_player.x, obj_player.y, 100, obj_hallway))
	{
		targetRoom = room_minimenu;
		targetDoor = "A";
		visible = false;
	}
}