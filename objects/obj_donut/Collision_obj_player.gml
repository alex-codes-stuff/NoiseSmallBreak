live_auto_call;
audio_play_sound(sfx_boing, 0, false)
var dir = point_direction(x, y, other.x, other.y);
with other
{
	state = states.bounce;
	sprite_index = spr_player_bounce;
	grounded = false;
	
	hsp = lengthdir_x(12, dir);
	vsp = lengthdir_y(12, dir);
	if hsp != 0
		xscale = sign(hsp);
	movespeed = abs(hsp);
}
