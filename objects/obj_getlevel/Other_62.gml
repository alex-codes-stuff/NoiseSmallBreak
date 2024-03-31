/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "id") == link)
{
	if (ds_map_find_value(async_load, "status") == 0)
	{
		
		buffer_write(buffer, buffer_string, ds_map_find_value(async_load, "result"))
		var _compressed_buff = buffer_compress(buffer, 0, buffer_tell(buffer))
		buffer_save(_compressed_buff, "onlinelevel.bblv")
		buffer_delete(buffer);
		buffer_delete(_compressed_buff);
		global.filename =  "onlinelevel.bblv"
 
    if global.filename != noone
	{
		with instance_create(obj_player.x, obj_player.y, obj_hallway)
		   targetRoom = room_customlevel
		 	audio_stop_all()
	}
	
	}

}






