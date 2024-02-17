// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_savescripttofile(){
   var _filename = argument0
   var _string = argument1
   
   var _buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1)
   buffer_write(_buffer, buffer_string, _string)
   buffer_save(_buffer, _filename)
   buffer_delete(_buffer)
}