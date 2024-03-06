/// @description Insert description here
// You can write your code in this editor
if global.play == 0
{
var xx = 0
var r = room_width div 32
draw_set_alpha(0.5)

repeat (r) 
{
	draw_line_color(xx, 0, xx, room_height, c_white, c_white)
	xx += 32
}

var yy = 0

r = room_height div 32
repeat (r) 
{
	draw_line_color(0, yy, room_width, yy, c_white, c_white)
	yy += 32
}

draw_set_alpha(1)


xx = mouse_x div 32
yy =mouse_y div 32
xx = xx*32
yy = yy*32
draw_set_alpha(0.5)
if flipped == 1
	draw_sprite_ext(selectsprite, 0, xx, yy, flipped, 1, image_angle, image_blend, 0.5)
else
   draw_sprite_ext(selectsprite, 0, xx+32, yy, flipped, 1, image_angle, image_blend, 0.5)
draw_set_alpha(1)
}


