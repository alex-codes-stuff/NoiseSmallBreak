 with other
{
	targetRoom = other.targetRoom;
	targetDoor = other.targetDoor;
	if targetRoom == testroom_1 && targetDoor = "X"
	{
	  obj_player.timerend = 1
	//  ds_list_clear(global.saveroom);
	}
	x = lerp(other.bbox_left, other.bbox_right, 0.5);
	
	if !instance_exists(obj_fadeout)
		instance_create(0, 0, obj_fadeout);
	toplayer = 0
	if instance_exists(obj_player2)
	   with obj_player2
	     toplayer = 0
}
