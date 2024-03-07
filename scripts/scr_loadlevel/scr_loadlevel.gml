// NEW FILE FORMAT: STRUCT: {root: array<struct>, room: array}
function scr_loadlevel(){
	with (all)
	{
		// TODO: MAKE THIS NOT SUPER FUCKIN LONG
		if object_index != obj_camera && object_index != obj_player && object_index != obj_noisette && object_index != obj_editor && object_get_parent(object_index) != obj_editorobject && object_index != obj_screensizer && object_index != obj_console
		   instance_destroy()
	}
	if file_exists(filename)
	{
		var _wrapper = scr_editor_decrypt(buffer_load(filename));
		//var _list = _wrapper[? "root"];
		var _list = _wrapper[$ "root"];
		
		//for (var i = 0; i < ds_list_size(_list); i++)
		for (var i = 0; i < array_length(_list); i++)
		{
			//var _map = _list[| i]
			var _map = _list[i];
			
			//var _test = _map[? "obj"];
			var _test = _map[$ "obj"];
			if i >= 5000 // Prevent crash (inf loop/so long it crashes)
			   exit;
			if _list != noone
			{
				with (instance_create(0, 0, asset_get_index(_test)))
				{
					/*x = _map[? "x"];
					y = _map[? "y"];
					image_xscale = _map[? "image_xscale"]
						image_yscale = _map[? "image_yscale"]
					if variable_instance_exists(id, "targetDoor")
					   targetDoorIndex = _map[? "targetDoorIndex"]*/
					x = _map[$ "x"];
					y = _map[$ "y"];
					image_xscale = _map[$ "image_xscale"];
					image_yscale = _map[$ "image_yscale"];
					if variable_instance_exists(id, "targetDoor") { targetDoorIndex = _map[$ "targetDoorIndex"]; }
					
				}
			}
		}
		//var _list2 = _wrapper[? "room"];
		var _list2 = _wrapper[$ "room"];
		//for (var i = 0; i < ds_list_size(_list2); i++)
		for (var i = 0; i < array_length(_list2); i++)
		{
			//var _map = _list2[| i]
			var _map = _list2[i];
			
			/*var _test = _map[? "room_width"];
			room_width = _test
			var _test2 = _map[? "room_height"];
			room_height = _test2
			var _test3 = _map[? "background_tint"];
			background_tint = _test3
			var _test4 = _map[? "song"];
			song = _test4*/
			var _test = _map[$ "room_width"];
			room_width = _test
			var _test2 = _map[$ "room_height"];
			room_height = _test2
			var _test3 = _map[$ "background_tint"];
			background_tint = _test3
			var _test4 = _map[$ "song"];
			song = _test4
		}
	}
}