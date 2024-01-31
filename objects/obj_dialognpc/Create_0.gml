/// @description Insert description here
// You can write your code in this editor
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
dialog = -4
dialogsprite = -4
image_speed = 0.35
function do_dialog(argument0) //gml_Script_do_dialog
{
    with (instance_create(x, y, obj_dialogcontroller))
    {
        npcID = other.id
        dialog = argument0
        dialogsprite = Font2
        currenttext = scr_calculate_text(dialog[0][0])
        dialogheight = scr_calculate_height(currenttext)
    }
    with (obj_player)
    {
        sprite_index = spr_player_idle
        image_speed = 0.35
        state = states.actor
        hsp = 0
        vsp = 0
        movespeed = 0
    }
}

