/// @description Insert description here
// You can write your code in this editor
if keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start)
{
	with instance_create(obj_player.x, obj_player.y, obj_hallway)
	    targetRoom = hub_1
}

