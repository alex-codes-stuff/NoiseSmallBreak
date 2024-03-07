// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialog_create(argument0, argument1, argument2, argument3) //gml_Script_dialog_create
{
	// https://manual.gamemaker.io/monthly/en/index.htm#t=GameMaker_Language/GML_Overview/Expressions_And_Operators.htm&rhsearch=Nullish&rhhlterm=Nullish
   return [argument0, argument1 ?? -4, argument2 ?? -4, argument3 ?? -4];
}