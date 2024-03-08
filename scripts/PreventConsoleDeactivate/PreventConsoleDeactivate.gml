#macro instance_deactivate_all instance_deactivate_all_hook2
#macro instance_deactivate_all_base instance_deactivate_all
function instance_deactivate_all_hook2(_notme) {
	instance_deactivate_all_base(_notme);
	instance_activate_object(obj_gmconsole);
	if (asset_get_index("obj_gmlive") != -1)
		instance_activate_object(obj_gmlive);
}

#macro instance_deactivate_layer instance_deactivate_layer_hook2
#macro instance_deactivate_layer_base instance_deactivate_layer
function instance_deactivate_layer_hook2(_layer) {
	instance_deactivate_layer_base(_layer);
	instance_activate_object(obj_gmconsole);
	if (asset_get_index("obj_gmlive") != -1)
		instance_activate_object(obj_gmlive);
}

#macro instance_deactivate_object instance_deactivate_object_hook2
#macro instance_deactivate_object_base instance_deactivate_object
function instance_deactivate_object_hook2(_object) {
	instance_deactivate_object_base(_object);
	instance_activate_object(obj_gmconsole);
	if (asset_get_index("obj_gmlive") != -1)
		instance_activate_object(obj_gmlive);
}

#macro instance_deactivate_region instance_deactivate_region_hook2
#macro instance_deactivate_region_base instance_deactivate_region
function instance_deactivate_region_hook2(_left, _top, _width, _height, _inside, _notme) {
	instance_deactivate_region_base(_left, _top, _width, _height, _inside, _notme);
	instance_activate_object(obj_gmconsole);
	if (asset_get_index("obj_gmlive") != -1)
		instance_activate_object(obj_gmlive);
}

#macro instance_create_depth instance_create_depth_hook2
#macro instance_create_depth_base instance_create_depth
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} _depth
/// @param {Asset.GMObject} _obj
/// @param {Struct}	_var_struct
/// @returns {Id.Instance}
function instance_create_depth_hook2(_x, _y, _depth, _obj, _var_struct = {})
{
	if (id != obj_gmconsole)	
		return instance_create_depth_base(_x, _y, _depth, _obj, _var_struct);
	else
		return instance_nearest(0, 0, obj_gmconsole);
}

#macro instance_create_layer instance_create_layer_hook2
#macro instance_create_layer_base instance_create_layer
/// @param {Real} _x
/// @param {Real} _y
/// @param {Id.Layer | String} _layer_id
/// @param {Asset.GMObject} _obj
/// @param {Struct}	_var_struct
/// @returns {Id.Instance}
function instance_create_layer_hook2(_x, _y, _layer_id, _obj, _var_struct = {})
{
	if (id != obj_gmconsole)	
		return instance_create_layer_base(_x, _y, _layer_id, _obj, _var_struct);
	else
		return instance_nearest(0, 0, obj_gmconsole);
}