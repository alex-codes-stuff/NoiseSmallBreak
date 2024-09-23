 /// @description Insert description here
// You can write your code in this editor
state = 0
queue = ds_queue_create()
interp = 0
thingy = 0
y += 15
_speed = random_range(0.01, 0.5)
queuerandom = random_range(90, 150)
thingy2 = 0
thingy3 = 0
thingy4 = 0
about_to_detect = 0
with (instance_create(x, y, obj_eggopp_detectionbox))
{
	target = other.id
}



