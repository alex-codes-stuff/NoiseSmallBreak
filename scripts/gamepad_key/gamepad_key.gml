// r
function gamepad_key(){
    if gamepad_button_check(0, gp_face1)
	{
		return gp_face1
	}
	 if gamepad_button_check(0, gp_face2)
	{
		return gp_face2
	}
	 if gamepad_button_check(0, gp_face3)
	{
		return gp_face3
	}
	 if gamepad_button_check(0, gp_face4)
	{
		return gp_face4
	}
	 if gamepad_button_check(0, gp_shoulderl)
	{
		return gp_shoulderl
	}
	 if gamepad_button_check(0, gp_shoulderlb)
	{
		return gp_shoulderlb
	}
	 if gamepad_button_check(0, gp_shoulderr)
	{
		return gp_shoulderr
	}
	 if gamepad_button_check(0, gp_shoulderrb)
	{
		return gp_shoulderrb
	}
	 if gamepad_button_check(0, gp_stickl)
	{
		return gp_stickl
	}
	 if gamepad_button_check(0, gp_stickr)
	{
		return gp_stickr
	}
	 if gamepad_button_check(0, gp_padu)
	{
		return gp_padu
	}
		 if gamepad_button_check(0, gp_padd)
	{
		return gp_padd
	}
	 if gamepad_button_check(0, gp_padl)
	{
		return gp_padl
	}
	 if gamepad_button_check(0, gp_padr)
	{
		return gp_padr
	}
	return 0

}