if wait > 5 && hit == 1
	{
		draw_sprite(spr_brickblock,1,x,y+spd)
		hit = 2
	}

switch (hit)
{
	case 1:
	{
		wait = wait + 1
		draw_sprite(spr_brickblock,1,x,y-spd)
	}
	
	case 2:
		draw_sprite(spr_baddie,1,x,y)
		
	default:

}