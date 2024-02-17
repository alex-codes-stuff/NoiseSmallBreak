/// @description Insert description here
// You can write your code in this editor
if global.play == 1
    visible = 0
else
   visible = 1
if open = 1
{
//	wall
    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50, xx, yy)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 0
	   
	//slope x, y+50+64, xx, yy
	
	 if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64, xx, yy+64)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 1
	   
	  //eggopp x, y+50+128, xx, yy+64*2
	  
	   if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+128, xx, yy+64*2)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 2
	   
	   //convex x, y+50+64*3, xx, yy+64*3
	   
	    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*3, xx, yy+64*3)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 3
	   
	   //collect x, y+50+64*4, xx, yy+64*4
	   
	     if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),x, y+50+64*4, xx, yy+64*4)) && mouse_check_button(mb_left)
	   obj_editor.selectnumber = 4
}




