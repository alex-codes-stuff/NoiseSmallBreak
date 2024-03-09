#region Define structs
parallax = {
	x: 0,
	y: 0,
	visible: true,
	speed: 1,
	spr: spr_upload_parallax,
	index: 0,
};

buttons = {
}

popup = {
	show: false,
}

changequeue = {
}
#endregion

/// @param	{Real}		_width
/// @param	{Real}		_height
/// @param	{String}	_text
/// @param	{String}	_button_text
function show_popup(_width, _height, _text)
{
	var _popup = popup; // In case we change popup struct
	
	_popup.show = true;
	_popup.width = _width;
	_popup.height = _height;
	_popup.text = _text;
	_popup.text += "\nClick anywhere on this box to hide.";
	_popup.height += string_height("\nClick anywhere on this box to hide.");
}	

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

/// @param	{String}				_name		Internal name, spaces will be changed to underscores
/// @param	{String}				_text
/// @param	{Real}					_x
/// @param	{Real}					_y
/// @param	{Real}					_width
/// @param	{Real}					_height
/// @param	{Bool}					_outline	If true, add an outline to the rectangle, color = text color
/// @param	{Array<Constant.Color>}	_color		Rectangle color, then text color
/// @param	{Constant.HAlign}		_halign		Both text and rect use the same!
/// @param	{Constant.VAlign}		_valign		Both text and rect use the same!
/// @param	{Function}				_func
/// @pure
function ButtonMeta(_name, _text, _x, _y, _width, _height, _outline, _color, _halign, _valign, _func) constructor
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
	func = _func;
}

/// @param	{Struct.ButtonMeta}	_btn_meta
function btn_add(_btn_meta)
{
	buttons[$ _btn_meta.name] = _btn_meta;
}

