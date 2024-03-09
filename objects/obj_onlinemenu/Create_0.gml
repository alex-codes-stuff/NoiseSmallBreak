#region Define structs
bg = {
	x: 0,
	y: 0,
	visible: true,
	speed: 1,
	spr: spr_online_bg,
	index: 0,
};

buttons = {
	metas: {},
	funcs: {},
	callbacks: {},
	changefuncs: {},
}

popup = {
	show: false,
}

changequeue = {
}

enum level_states
{
	not_searched,
	searching,
	searched,
}

lvls = {
	search: {
		state: level_states.not_searched,
		array: [],
	},
}
#endregion

prev_kbdstr = keyboard_string;
selected_textbox = undefined;
nickname = "";

/// @param	{String}	_text
/// @param	{Real}		_width
/// @param	{Real}		_height
function show_popup(_text, _width = string_width(_text) * 1.5, _height = string_height(_text) * 1.5)
{
	var _popup = popup; // In case we change popup struct
	
	var _closetxt = "Click anywhere on this box to close.";
	
	_popup.show = true;
	_popup.width = max(_width, string_width($"\n{_closetxt}"));
	_popup.height = _height;
	_popup.text = _text;
	_popup.text += $"\n{_closetxt}";
	_popup.height += string_height($"\n{_closetxt}");
}	

#region BUTTON FUNCTIONS

/// @param		{Struct.ButtonMeta}	_btn
/// @returns	{Array<Real>}
function btn_get_offset(_btn)
{
	var _offset = [0, 0];
	switch (_btn.halign)
	{
		default:
		case fa_left:
			_offset[0] = 0;
		break;
		
		case fa_center:
			_offset[0] = _btn.width / 2;
		break;
		
		case fa_right:
			_offset[0] = _btn.width;
		break;
	}
	
	switch (_btn.valign)
	{
		default:
		case fa_top:
			_offset[1] = 0;
		break;
		
		case fa_middle:
			_offset[1] = _btn.height / 2;
		break;
		
		case fa_bottom:
			_offset[1] = _btn.height;
		break;
	}
	
	// Feather disable once GM1045
	// Stupid feather
	return _offset;
}

/// @param		{String}	_name
/// @returns	{Function}	Success => Function; Fail/Empty => undefined
function btn_get_changefunc(_name)
{
	var _btn = btn_get(_name)
	if (struct_exists(_btn, "changefunc")) { return _btn.changefunc; }
	
	return undefined;
}

/// @param		{String}	_name
/// @returns	{Function}	Success => Function; Fail/Empty => undefined
function btn_get_callback(_name)
{
	var _btn = btn_get(_name)
	if (struct_exists(_btn, "callback")) { return _btn.callback; }
	
	return undefined;
}

/// @param		{String}		_name
/// @returns	{Function}		Success => Function; Fail => Undefined
function btn_get_func(_name)
{
	var _btn = btn_get(_name);
	if (struct_exists(_btn, "func")) { return _btn.func; }
	
	return undefined;
}

/// @param		{String}				_name
/// @returns	{Struct.ButtonMeta}		Success => ButtonMeta; Fail => Empty struct
/// @pure
function btn_get_meta(_name)
{
	var _btn = btn_get(_name);
	if (struct_exists(_btn, "meta")) { return _btn.meta }
	return {};
}

/// @param		{String}			_name
/// @returns	{Struct.Button}		Success => Button; Fail => Empty struct
/// @pure
function btn_get(_name)
{
	for (var i = 0; i < struct_names_count(buttons.metas); i++)
	{
		var _k = buttons.metas[$ struct_get_names(buttons.metas)[i]];
		if (_k.name == _name) 
		{
			var _func = buttons.funcs[$ _k.name];
			var _cback = buttons.callbacks[$ _k.name];
			var _changefunc = buttons.changefuncs[$ _k.name];
			//return {meta: _k, func: _func};
			// Feather disable once GM1045
			return new Button(_k, _func, _cback, _changefunc);
		}
	}
	
	// Feather disable once GM1045
	return {};
}

#endregion

#region COnstructorz

function Button(_meta, _func, _cback = undefined, _changefunc = undefined) constructor
{
	meta = _meta;
	func = _func;
	callback = _cback;
	changefunc = _changefunc;
}

/// @param	{String}				_name		Internal name, spaces will be changed to underscores
/// @param	{String}				_text		If input box, 
/// @param	{Real}					_x
/// @param	{Real}					_y
/// @param	{Real}					_width
/// @param	{Real}					_height
/// @param	{Bool}					_outline	If true, add an outline to the rectangle, color = text color
/// @param	{Array<Constant.Color>}	_color		Rectangle color, then text color
/// @param	{Constant.HAlign}		_halign		Both text and rect use the same!
/// @param	{Constant.VAlign}		_valign		Both text and rect use the same!
/// @param	{Array}					_input_box	Yes/No; Font; Character limit (0 for none)
/// @pure
function ButtonMeta(_name, _text, _x, _y, _width, _height, _outline, _color, _halign, _valign, _input_box = [false, Font2, 0]) constructor
{
	name = string_letters(string_replace_all(string_lower(_name), " ", ""));
	text = _text;
	x = _x;
	y = _y;
	width = _width;
	height = _height;
	outline = _outline;
	color = _color;
	halign = _halign;
	valign = _valign;
	input_box = _input_box;
	array_insert(input_box, 2, ""); // Text
}

/// @param		{Struct.ButtonMeta}		_btn_meta
/// @param		{Function}				_func			If you're making a search box, return true to clear search and false to not
/// @param		{Function | Undefined}	_callback		If defined, this is called after execution logic, Calls with your button object as argument 1.
/// @param		{Function | Undefined}	_changefunc		INPUT BOX ONLY: If defined, called each time the value is changed. Argument 1 is your button, argument 2 is the text. Text will be changed to return value.
/// @returns	{Struct.Button}
function btn_add(_btn_meta, _func, _callback = undefined, _changefunc = undefined)
{
	if (!_btn_meta.input_box[0] && _changefunc != undefined) { var _msg = "Buttons cannot have changefuncs, use callbacks instead."; throw({message: _msg, longMessage: _msg, stacktrace: debug_get_callstack(), line: -1}); }
	
	for (var i = 0; i < struct_names_count(buttons.metas); i++)
	{
		var _k = buttons.metas[$ struct_get_names(buttons.metas)[i]];
		if (_k.name == _btn_meta.name)
		{
			var _msg = $"Tried to add button {_btn_meta.name} more than once";
			throw({message: _msg, longMessage: _msg, stacktrace: debug_get_callstack(), line: -1});
		}
	}
	
	buttons.metas[$ _btn_meta.name] = _btn_meta;
	buttons.funcs[$ _btn_meta.name] = _func;
	if (!is_undefined(_callback)) { buttons.callbacks[$ _btn_meta.name] = _callback; }
	if (!is_undefined(_callback)) { buttons.changefuncs[$ _btn_meta.name] = _changefunc; } 
	
	return new Button(_btn_meta, _func, _callback, _changefunc);
}

#endregion

//btn_add(new ButtonMeta("testsearch", "TEST SEARCH", 500, 300, 250, 100, true, [c_black, c_white], fa_center, fa_middle, [true, Font3]), function(_input) { show_debug_message(_input); });

event_perform(ev_alarm, 0);