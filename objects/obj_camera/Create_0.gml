// Feather disable once GM1034
// Feather disable once GM1033
live_auto_call;

global.mainplayer = obj_player
#macro CAMX camera_get_view_x(view_camera[0])
#macro CAMY camera_get_view_y(view_camera[0])
#macro CAMW camera_get_view_width(view_camera[0]) 
#macro CAMH camera_get_view_height(view_camera[0]) 
//window_set_fullscreen(1);
chargecam = 0;
flycam = 0;
shake = 0
shakestrength = 0
global.points = 0
global.timeattack = 0
bruh = 0
_camx = 0
_camy = 0
_camw = 0
_camh = 0