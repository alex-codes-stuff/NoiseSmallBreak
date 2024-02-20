/// @description Insert description here
// You can write your code in this editor
draw_set_font(Font2)

draw_set_alpha(1)

if index == 1
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,200, "BACK")

if index == 2
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,300, "LEVEL EDITOR")

if index == 3
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,400, "LOAD LEVEL")

if index == 4
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,500, "EDITOR GUIDE")


draw_set_color(c_white)