// helped by raf13lol on discord, made the code readable and fixed a crash
// OLD FILE FORMAT: DS MAP: (root: DS LIST<array>, room: DS LIST)
function scr_savelevel_old(){
    // we'll keep this here just in case
	ds_list_clear(dslisttest)
	ds_list_clear(dslisttest2)

    var objects_to_save = [obj_solid, obj_slope, obj_convexslope, 
        obj_collect, obj_destroyable, obj_doorA, obj_hallway34, obj_doorB, obj_doorX, obj_eggopp, obj_spike, obj_levelfinish] // write your extra objects here

    var variables_to_save = ["x", "y", 
        "image_xscale", "image_yscale"] // please ensure each variable does exist in each object if you add any custom variables (not gm builtin obj vars)
        
    var specific_variables_to_save = {
        "obj_hallway34": ["targetDoorIndex"]
		
       
    }
    
    var objlen = array_length(objects_to_save)
    var varlen = array_length(variables_to_save)
    for (var i = 0; i < objlen; i++)
    {
        var obj = objects_to_save[i]
        with obj
        {
            if object_index == obj
            {
                map = ds_map_create()
                ds_list_add_map(other.dslisttest, map)

                var objname = object_get_name(obj)
                ds_map_add(map, "obj", objname)
                for (var j = 0; j < varlen; j++)
                {
                    var var_to_save = variables_to_save[j]
                    ds_map_add(map, var_to_save, variable_instance_get(id, var_to_save))
                }
                if struct_exists(specific_variables_to_save, objname)
                {
                    var specific_variables = struct_get(specific_variables_to_save, objname)
                    var specificvarlen = array_length(specific_variables)
                    for (var k = 0; k < specificvarlen; k++)
                    {
                        var var_to_save = specific_variables[k]
                        ds_map_add(map, var_to_save, variable_instance_get(id, var_to_save))
                    }
                }
            }
        }
    }

    map = ds_map_create()
    ds_list_add_map(other.dslisttest2, map)

	ds_map_add(map, "room_width", room_width)
	ds_map_add(map, "room_height", room_height)
	ds_map_add(map, "background_tint", background_tint)
	ds_map_add(map, "song", song)
	
    wrapper = ds_map_create()
    ds_map_add_list(wrapper, "root", dslisttest)
    ds_map_add_list(wrapper, "room", dslisttest2)

    var save = json_encode(wrapper)
    scr_savestringtofile(filename, save)

    ds_map_destroy(wrapper)
    ds_map_destroy(map)

    dslisttest = ds_list_create() // ds_map_destroy will destroy these as well sooo
    dslisttest2 = ds_list_create()

    show_debug_message("saved")
}

// ds_list_add_map defined in new savelevel