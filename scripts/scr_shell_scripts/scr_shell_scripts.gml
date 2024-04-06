function sh_noise_hurt() {
    with (obj_player)
	scr_hurtplayer()
}
function meta_noise_hurt() {
	return {
		description: "hurt The Noise"
	}
}