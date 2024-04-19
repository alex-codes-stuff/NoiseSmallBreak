/// @description Insert description here
// You can write your code in this editor
var _cam_x = camera_get_view_x(view_camera[0])
var _cam_y = camera_get_view_y(view_camera[0])
var lay_arr = layer_get_all()
for (var i = 0; i < array_length(lay_arr); i++)
{
    var lay = lay_arr[i]
    var lay_name = layer_get_name(lay)
    switch lay_name
    {
        case "Assets_Parrallax1":
            layer_x(lay, (_cam_x * 0.3))
            layer_y(lay, (_cam_y * 0.3))
            break
	    case "Assets_Parrallax2":
            layer_x(lay, (_cam_x * 0.5))
            layer_y(lay, (_cam_y * 0.5))
            break
		case "Assets_Parrallax0":
            layer_x(lay, (_cam_x * -0.1))
            layer_y(lay, (_cam_y * -0.1))
            break
			
		case "Assets_Parrallax0Scroll":
		 
            layer_x(lay, ((_cam_x * 0.1)+ bg_scroll2x))
            layer_y(lay, ((_cam_y * 0.1) + bg_scroll2y))
			bg_scroll2x += layer_get_hspeed(lay)
            bg_scroll2y += layer_get_vspeed(lay)
            break
	     case "Assets_Parrallax2Scroll":
		  
			bg_scroll3x += layer_get_hspeed(lay)
            bg_scroll3y += layer_get_vspeed(lay)
          layer_x(lay, ((_cam_x * 0.5)+ bg_scroll3x))
            layer_y(lay, ((_cam_y * 0.5) + bg_scroll3y))
            break
	}
}





