/// @description Insert description here
// You can write your code in this editor
if global.play == 1
    visible = 0
else
   visible = 1
if open = 1
{
//	wall
thingy2 = 0
    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50, xx, yy)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 0
	   
	//slope x, y+50+64, xx, yy
	thingy2 += 1
	 if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 1
	   
	  //eggopp x, y+50+128, xx, yy+64*thingy2
	  thingy2 += 1
	   if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+128, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 2
	   
	   //convex x, y+50+64*thingy3, xx, yy+64*thingy3
	   thingy2 += 1
	    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 3
	   
	   //collect x, y+50+64*thingy4, xx, yy+64*thingy4
	   thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 4
	     thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 5
	     thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 6
	     thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 7
	     thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 8
	     thingy2 += 1
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*thingy2, xx, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 9
	   
	   //(x+32, y+50+64*thingy, xx, yy+64*thingy
	      if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x+64, y+50+64*thingy2, xx+64, yy+64*thingy2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 10
}




