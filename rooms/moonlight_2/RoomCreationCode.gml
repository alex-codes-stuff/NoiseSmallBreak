audio_resume_sound(mu_orange)
audio_stop_sound(mu_secret)
if !audio_is_playing(mu_orange)
{
	audio_stop_all()
	audio_play_sound(mu_orange, 0, 1)
	
}