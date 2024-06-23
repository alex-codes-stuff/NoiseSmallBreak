/// @description Insert description here
// You can write your code in this editor
currentchangelog = 0
changelogAmount = 1
changelog = "Loading..."
latestchangelog = http_get("https://pastebin.com/raw/9xHHFHpk")
bg = {
	x: 0,
	y: 0,
	visible: false,
	speed: 1,
	spr: spr_minimenu_bg,
	index: 0,
	image_alpha: 1,
};
