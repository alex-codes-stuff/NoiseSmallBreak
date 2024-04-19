/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor

if usestatic == 1
{
	draw_sprite_stretched(spr_tvstatic, static_index, 0, 0, 1280, 720)
	if reverse == 0
		static_index += 0.35
	if reverse == 1
		static_index -= 0.35
}
if reverse == 0
{
	if static_index > image_number
	{
	  static_index = image_number
	  usestatic = 0
	  if _idk == 0
			{
		          _idk = 1
				  alarm[0] = 60
			}
	}
}
else
{
	if static_index < 0.1
	{
		instance_destroy()
	}
}
if usestatic == 0 && reverse == 0
{
	drawsprite = 1
}
if drawsprite == 1
{
	draw_sprite_stretched(spr_noisedifficultybg, 0, 0, 0, 1280, 720)
	draw_sprite_stretched(spr_noisedifficulty, 0, 20, 220,637, 557)
}
if usestatic == 0
{
	drawsprite = 1
}
if usestatic == 1
{
	drawsprite = 0
}






