// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @param {String}				_filename
/// @param {String | Id.Buffer}	_data
function scr_savestringtofile(_filename, _data)
{
	var _buffer = buffer_create(string_byte_length(_data)+1, buffer_fixed, 1)
	buffer_write(_buffer, buffer_string, _data)
	buffer_save(_buffer, _filename)
	buffer_delete(_buffer)
}