/// @description Insert description here
// You can write your code in this editor
draw_set_font(Font2)
switch menu
{
	case 1:
draw_set_alpha(1)
distance = 125
if index == 1
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "BACK")
distance+=distanceamount
if index == 2
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "LEVEL EDITOR")
distance+=distanceamount
if index == 3
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "LOAD LEVEL")
distance+=distanceamount
if index == 4
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "EDITOR GUIDE")

distance+=distanceamount
if index == 5
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "SETTINGS")
break
case 2:
draw_set_alpha(1)
distance = 125
if index == 1
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "BACK")
distance+=distanceamount
if index == 2
draw_set_color(c_yellow)
else
draw_set_color(c_white)
draw_text(300,distance, "COOP MODE: " + string(global.coop))
distance+=distanceamount
   
}




draw_set_color(c_white)