/// @description Insert description here
// You can write your code in this editor
if global.play == 1
{
with instance_create_depth(obj_player.x, obj_player.y, 100, obj_hallway)
{
	targetRoom = room_minimenu
	targetDoor = "A"
	visible = false
}
}




