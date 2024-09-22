ds_list_add(global.saveroom, id);

with instance_create(x, y, obj_collect_goto_teacup)
{
	_x = array_get(scr_room_to_gui(other.x, other.y), 0)
	_y = array_get(scr_room_to_gui(other.x, other.y), 1)
	goto_x = 160
	goto_y = 152
}
	
	