if !audio_is_playing(mu_night)
	audio_play_sound(mu_night, 0, 1)
audio_stop_sound(mu_orange)
audio_stop_sound(mu_secret)
global.level = "clocktower"
if obj_player.timer == 0
	obj_player.alarm[0] = room_speed * 0.1