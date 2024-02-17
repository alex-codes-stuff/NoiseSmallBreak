// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_jsonthing(){
   var _filename = argument0
   
   var _buffer = buffer_load(_filename)
   var _string = buffer_read(_buffer, buffer_string)
   
   buffer_delete(_buffer)
   
   var _json = json_decode(_string)
   return _json
}