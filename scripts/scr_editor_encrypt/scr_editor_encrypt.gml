/// @function							scr_editor_encrypt(data)
/// @description						Encrypts the file. This actually works with any struct, but is made for the lvl editor.
/// @param		{Struct}				data	Struct to encrypt.
/// @returns	{Id.Buffer|Undefined}	Success => Buffer; Fail => undefined
function scr_editor_encrypt(data)
{
	if (string_pos(typeof(data), "struct") == 0) { return undefined; }
	var b64json = undefined;
	_b64json = {};
	struct_foreach(data, function(key, value)
	{
		// Went overkill, this causes a stack overflow
		/*
		var shift = irandom_range(6, 60)
		var shift_str = shift < 10 ? $"0{string(shift)}" : string(shift); // Ensures consistently having 2 chars
		
		var val = string(value);
		var newval = "";
		
		for (var i = 0; i < string_length(val); i++)
		{
			// Should have read the documentation saying that this is super slow lmao
			newval += string_set_byte_at(val, i + 1, string_byte_at(val, i) + shift);
		}
		_b64json[$ key] = base64_encode(json_stringify(newval) + shift_str);*/
		
		_b64json[$ key] = base64_encode(json_stringify(value));
	});
	b64json = _b64json;
	_b64json = undefined;
	var b64json_str = base64_encode(json_stringify(b64json));
	
	// Buffer creation & compression
	var buff = buffer_create(1024, buffer_grow, 1);
	buffer_write(buff, buffer_string, b64json_str);
	var compressed_buff = buffer_compress(buff, 0, buffer_tell(buff));
	
	buffer_delete(buff);

	var _ret = compressed_buff == -1 ? undefined : compressed_buff;
	return _ret;
}

/// @param		{String | Id.Buffer}	filename_or_buff
/// @returns	{Struct}
function scr_editor_decrypt(filename_or_buff)
{
	var compressed_buff = (is_string(filename_or_buff) ? buffer_load($"{working_directory}{filename_or_buff}") : filename_or_buff);
	var decomp_buff = buffer_decompress(compressed_buff);
	var b64json_from_buff = buffer_read(decomp_buff, buffer_string);
	var b64json = base64_decode(b64json_from_buff);
	var b64json_parsed = json_parse(b64json);
	var json = undefined;
	_json = {};
	struct_foreach(b64json_parsed, function(key, value)
	{
		_json[$ key] = json_parse(base64_decode(value));
	});
	json = _json;
	_json = undefined;
	var json_str = json_stringify(json);
	
	// Cleanup
	buffer_delete(decomp_buff);
	
	return json;
}
	