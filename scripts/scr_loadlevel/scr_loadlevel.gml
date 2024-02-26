// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadlevel(){
	with (all)
	{
		if object_index != obj_camera && object_index != obj_player && object_index != obj_noisette && object_index != obj_editor && object_index != obj_screensizer && object_index != obj_particlesystem  && object_index != obj_savehitbox  && object_index != obj_testhitbox  && object_index != obj_objecttab && object_index != obj_roomsizehitbox
		   instance_destroy()
	}
if file_exists(filename)
	{
		
		var _wrapper = scr_jsonthing(filename)
		var _list = _wrapper[? "root"];
		
		for (var i = 0; i < ds_list_size(_list); i++)
		{
			var _map = _list[| i]
			
			var _test = _map[? "obj"];
			if i >= 5000
			   exit;
			if _list != noone
			{
			with (instance_create(0, 0, asset_get_index(_test)))
			{
				x = _map[? "x"];
				y = _map[? "y"];
				image_xscale = _map[? "image_xscale"]
					image_yscale = _map[? "image_yscale"]
				if variable_instance_exists(id, "targetDoor")
				   targetDoorIndex = _map[? "targetDoorIndex"]
		
					
			}
			}
		}
		var _list2 = _wrapper[? "room"];
		for (var i = 0; i < ds_list_size(_list2); i++)
		{
			var _map = _list2[| i]
			
			var _test = _map[? "room_width"];
			room_width = _test
			var _test2 = _map[? "room_height"];
			room_height = _test2
			var _test3 = _map[? "background_tint"];
			background_tint = _test3
			var _test4 = _map[? "song"];
			song = _test4
			
			
	       
		}
	}
}