live_auto_call;

event_inherited();
switch state
{
	case 1:
	    	gamepad_set_vibration(0, 0.7, 0.7);
	obj_player.alarm[4] = 3
		player.state = states.bounce;
		player.sprite_index = spr_player_bounce;
		player.movespeed = 2;
		player.vsp = -20;
		player.grounded = false;

		state = 0;
		break;
}
