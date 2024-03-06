audio_resume_sound(mu_orange)
audio_stop_sound(mu_secret)
global.level = "moonlight"
if !audio_is_playing(mu_orange)
{
	audio_stop_all()
	audio_play_sound(mu_orange, 0, 1)
	
}
if obj_player.timer == 0
obj_player.alarm[0] = game_get_speed(gamespeed_fps) * 0.1