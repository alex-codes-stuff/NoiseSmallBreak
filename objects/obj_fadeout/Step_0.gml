if fadeout
{
	image_alpha = Approach(image_alpha, 1, 0.1);
	if image_alpha >= 1
	{
		fadeout = false;
		if room != room_editor
		{
		with obj_player
			room_goto(targetRoom);
		}
		else
		{
		if obj_player.targetDoor == "A"
		    {
			obj_player.x = obj_doorA.x	
				obj_player.y = obj_doorA.y - 30
			}
		
		
		if obj_player.targetDoor == "B"
		    {
			obj_player.x = obj_doorB.x	
				obj_player.y = obj_doorB.y - 30
			}
		
		
		if obj_player.targetDoor == "X"
		    {
			obj_player.x = obj_doorX.x	
				obj_player.y = obj_doorX.y - 30
			}
		
		}
		   
	}
}
else
{
	image_alpha = Approach(image_alpha, 0, 0.1);
	if image_alpha <= 0
		instance_destroy();
}
