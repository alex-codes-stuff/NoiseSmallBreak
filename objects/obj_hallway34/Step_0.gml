with instance_place(x, y, obj_doorX)
	other.targetDoor = door;
if room == room_editor
{
	switch targetDoorIndex
	{
	  case 0:
	     targetDoor = "A"
		 break
	   case 1:
	     targetDoor = "B"
		 break
		  case 2:
	     targetDoor = "C"
		 break
		  case 3:
	     targetDoor = "A"
		 targetDoorIndex = 0
		 break
	}
	   
}