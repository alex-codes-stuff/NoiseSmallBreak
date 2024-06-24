/// @description Insert description here
// You can write your code in this editor
bg = {
	x: 0,
	y: 0,
	visible: false,
	speed: 1,
	spr: spr_minimenu_bg,
	index: 0,
	image_alpha: 1,
};
_x = 0
_alpha = 0
levelid = ""
index = 1
//buttons = 3
distance = 0
distanceamount = 100
//audio_stop_sound(mu_secret)

audio_play_sound(mu_menu, 1, true)
setkey = 0
global.filename = ""
menu = 1;
controllerright = false;
controllerleft = false;
controllerup = false;
controllerdown = false;
controllera = false;
delaydown = 0;
delayup = 0;
delayleft = 0;
delayright = 0;
pauseScreenshot = -4