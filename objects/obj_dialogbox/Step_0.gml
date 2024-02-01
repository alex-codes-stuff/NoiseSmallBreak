/// @description Insert description here
// You can write your code in this editor
if draw == 1 && (keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(0, gp_face1))
{
	draw = 0
	obj_player.state = states.normal
}
if (abs((x - obj_player.x)) > 30)
    image_xscale = sign((obj_player.x - x)) *1.25
if place_meeting(x, y, obj_player)
{
	arrow = 1
}
else
    arrow = 0