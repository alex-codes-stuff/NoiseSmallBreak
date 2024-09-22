/// @description Insert description here
// You can write your code in this editor

with (obj_player)
    state = other.savedstate
var func = 1
if (func != -4)
{
    if (npcID != noone && instance_exists(npcID))
    {
        with (npcID)
            self.method(id, func)()
    }
    else
        self.method(id, func)()
}
width -= 150
if width < 0
   width = 0
