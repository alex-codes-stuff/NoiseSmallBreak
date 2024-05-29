live_auto_call;
toplayer = 0
if (room == hub_1 || room == room_editor) && state == states.actor
{
     state = states.normal
	 x = asset_get_index("obj_door" + targetDoor).x
	  y = asset_get_index("obj_door" + targetDoor).y
}
if (room == moonlight_1 || room == testroom_1) && targetDoor == "A"
{
	with instance_create(obj_doorA.x+30 ,obj_doorA.y-100, obj_hallway34)
	{
		sprite_index = spr_shuttle_move
		backToShuttle = 1
		sprite_index = spr_shuttle_move
		image_yscale = -1
		y -= 700
	}
}
if global.coop
	if global.mainplayer != obj_player2
	{
		x = obj_player.x
		y = obj_player.y
	}
if room == moonlight_1 && targetDoor == "A"
{
    
	global.timeattack = 0
}
var door_obj = noone;
with obj_doorX
{
	if door == other.targetDoor
	{
		door_obj = id;
		break;
	}
}

if door_obj
{
	x = door_obj.x + 16;
	y = door_obj.y - 14;
	
	var hallway = instance_place(x, y, obj_hallway);
	if hallway
		x = hallway.x + hallway.sprite_width + (-sign(hallway.image_xscale) * 200);
	
	var hallway = instance_place(x, y, obj_verticalhallway);
	if hallway
	{
		trace(verticalpos);
		
		x = hallway.x + (hallway.sprite_width * verticalpos);
		var bbox_size = abs(bbox_right - bbox_left);
		x = clamp(x, hallway.x + bbox_size, hallway.bbox_right - bbox_size);
		
		if hallway.image_yscale < 0
			y = hallway.bbox_bottom + 32;
		else
			y = hallway.bbox_top - 78;
		
		vsp = verticalspd;
		if state == states.wallslide
		{
			var move = verticalpos > .5 ? 1 : -1;
			for(var i = 1; i < 32; i++)
			{
				if place_meeting(x + i * move, y, obj_solid)
				{
					x += (i - 1) * move;
					break;
				}
			}
		}
	}
}
if global.coop == 0
{
instance_create(x, y, obj_noisette);
}
