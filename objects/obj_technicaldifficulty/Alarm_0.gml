/// @description Insert description here
// You can write your code in this editor
reverse = 1
usestatic = 1
audio_play_sound(sfx_tvswitchback, 0, 0)
 obj_player.x = asset_get_index("obj_door"+obj_player.targetDoor).x
 obj_player.y = asset_get_index("obj_door"+obj_player.targetDoor).y - 20
 obj_player.state = states.normal




