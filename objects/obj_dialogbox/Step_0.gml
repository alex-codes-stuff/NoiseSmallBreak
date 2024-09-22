/// @description Insert description here
// You can write your code in this editor
if place_meeting(x, y, obj_player) 
{
	var _do = 1;
	with (obj_dialogbox)
	{
		if (id != other.id) //not self
		{
			if (draw == true)
			{
				_do = 0;
			}
		}	
	}
	if (_do == 1)
	{
		draw = true
		thingy = false
	}
	
}
else if thingy == false
{
	thingy = true
	alarm[0] = 30
	
	
}
//if (abs((x - obj_player.x)) > 30)
//    image_xscale = sign((obj_player.x - x)) *1.25
if draw == 1
{
	if retract == false
	{
		width -= 70
		if width < 0
		   width = 0
	}
}
else 
	width = 880
if retract == true
{
	width += 70
	if width > 880
	{
	   width = 880
	   draw = false
	   retract = false
	}
}