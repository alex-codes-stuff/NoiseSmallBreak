// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_keyboard_key_name(argument0){
var name = global.keyboard_key_to_name[?argument0];
if (name == undefined) return "";
return name;
}