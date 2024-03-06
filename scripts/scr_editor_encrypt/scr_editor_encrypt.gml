function string_to_bytes(_str)
{
	var _ret = [];
	for (var i = 0; i < string_length(_str) < i; i++)
	{
		array_push(_ret, string_byte_at(_str, i));
	}
}

function scr_editor_is_same_sample(sample)
{
	return sample == scr_editor_encrypt_get_sample();
}

/// @function						scr_editor_encrypt(data)
/// @description					Encrypts the file. This actually works with any struct, but is made for the lvl editor.
/// @param		{Struct}	data	Struct to encrypt.
/// @returns	{Bool | Id.Buffer}	Success => Buffer; Fail => false
function scr_editor_encrypt(data)
{
	var b64json = undefined;
	_b64json = {};
	struct_foreach(data, function(key, value)
	{
		/*
		var shift = irandom_range(6, 60)
		var shift_str = shift < 10 ? $"0{string(shift)}" : string(shift); // Ensures consistently having 2 chars
		// Went overkill, this causes a stack overflow
		
		var val = string(value);
		var newval = "";
		
		for (var i = 0; i < string_length(val); i++)
		{
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
	buffer_write(buff, buffer_string, sha1_string_utf8(b64json_str));
	var compressed_buff = buffer_compress(buff, 0, buffer_tell(buff));
	
	buffer_delete(buff);
	// Feather disable GM1063
	return compressed_buff == -1 ? false : compressed_buff;
}

/// @param	{String | Id.Buffer}	filename_or_buff
function scr_editor_decrypt(filename_or_buff)
{
	var compressed_buff = (is_string(filename_or_buff) ? buffer_load($"{working_directory}{filename_or_buff}") : filename_or_buff);
	var decomp_buff = buffer_decompress(compressed_buff);
	var b64json_from_buff = buffer_read(decomp_buff, buffer_string);
	var b64json = base64_decode(b64json_from_buff);
	var hash = buffer_read(decomp_buff, buffer_string);
	if (sha1_string_utf8(b64json_from_buff) != hash)
	{
		return false;
	}
	show_message("JSON 1");
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
	