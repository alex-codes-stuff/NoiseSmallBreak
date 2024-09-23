/// @description Insert description here
// You can write your code in this editor
global.selectedlevel = 0
selectedObj = obj_planet1
key_right = 0
key_left = 0
zoom = 0.6
ini_open("SaveData.ini");
moonlightUnlocked = "BEST TIME: " + ini_read_string("moonlight", "time", "None")
ini_close()





