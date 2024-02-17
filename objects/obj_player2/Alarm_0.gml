 /// @description Insert description here
// You can write your code in this editor
timer += 0.1
if timerend == 0
{
	alarm[0] = room_speed * 0.1
	
}

else
    audio_play_sound(sfx_finish, 0, 0)
if losehp == 0
{
if global.level == "junkbeach"
{
if timer >= 49.9  
	{
	if global.timeattack
	{
		losehp = 1
		alarm[1] = room_speed * 0.1
	}
	}
}
else 
	{
	if timer >= 160
	{
	if global.timeattack
	{
		losehp = 1
		alarm[1] = room_speed * 0.1
	}
	}	
	}
}
