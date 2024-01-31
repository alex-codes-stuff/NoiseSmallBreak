// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialog_create(argument0, argument1, argument2, argument3) //gml_Script_dialog_create
{
    if (argument1 == undefined)
        argument1 = -4
    if (argument2 == undefined)
        argument2 = -4
    if (argument3 == undefined)
        argument3 = -4
    return [argument0, argument1, argument2, argument3];
}

