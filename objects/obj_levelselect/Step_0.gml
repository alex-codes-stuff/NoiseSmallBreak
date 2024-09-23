/// @description Insert description here
// You can write your code in this editor
if moonlightUnlocked != "None"
{
	if obj_player.key_right && key_right == false
	   {
		   key_right = true
		   global.selectedlevel = (global.selectedlevel == 0 ? 1 : 0)
		   with obj_planetpointer
		   {
			   if global.selectedlevel == 1
			   {
				  speed = 9.5
			   }
			   if global.selectedlevel == 0
			   {
				  speed = -9.5
			   }
		   }
	   
	   }
 
	if !obj_player.key_right
	   key_right = false
   
	if obj_player.key_left == -1 && key_left == false
	   {
		   key_left = true
		   global.selectedlevel = (global.selectedlevel == 0 ? 1 : 0)
		   with obj_planetpointer
		   {
			   if global.selectedlevel == 1
			   {
				  speed = 9.5
			   }
			   if global.selectedlevel == 0
			   {
				  speed = -9.5
			   }
		   }
	   
	   }
 
	if obj_player.key_left != -1
	   key_left = false
}
switch global.selectedlevel
{
	case 0:
		selectedObj = obj_planet1
		
	break
	case 1:
		selectedObj = obj_planet2
	break
}
if zoom < 0.6 && selectedObj = obj_planet1
{
	zoom += 0.0035
}
if zoom > 0.5 && selectedObj = obj_planet2
{
	zoom -= 0.0035
}
obj_camera.zoom = zoom
if obj_player.key_jump2
{
	var _targetRoom = (global.selectedlevel == 0 ? testroom_1 : moonlight_1)
	with instance_create(obj_player.x, obj_player.y, obj_hallway)
	{
		
		targetRoom = _targetRoom
		targetDoor = "A"
	}
}



