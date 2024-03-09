/// @description Detect kliks, lik 3kliksphilip frfr ong

if (mouse_check_button_pressed(mb_left))
{
	if (!popup.show)
	{
		for (var i = 0; i < struct_names_count(buttons); i++)
		{
			var _btn = buttons[$ struct_get_names(buttons)[i]];
			
			var _mousepos = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
			var _check = [false, false];
			var _offset = btn_get_offset(_btn);
			if (_mousepos[0] >= _btn.x - _offset[0] && _mousepos[0] <= _btn.x - _offset[0] + _btn.width) {  _check[0] = true; }
			if (_mousepos[1] >= _btn.y - _offset[1] && _mousepos[1] <= _btn.y - _offset[1] + _btn.height) { _check[1] = true; }
			
			show_debug_message($"{_mousepos[0]} between {_btn.x - _offset[0]} and {_btn.x - _offset[0] + _btn.width}");
			show_debug_message($"{_mousepos[1]} between {_btn.y - _offset[1]} and {_btn.y - _offset[1] + _btn.height}");
			if (_check[0] && _check[1])
			{
				show_debug_message($"Press: {_btn.name}");
				try
				{
					_btn.func();
					throw({message: "a"});
				} 
				catch (_e)
				{
					var _msg = $"Exception pressing button {_btn.name}.";
					show_popup(string_width(_msg) * 1.5, string_height(_msg) * 1.5, _msg);
					show_debug_message($"{_msg}\n---\nDumping exception struct.\n{string(_e)}\n---");
				}
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