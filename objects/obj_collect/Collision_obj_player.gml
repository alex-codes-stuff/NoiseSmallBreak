if ++global.collect >= 20 && obj_player.hp < 7
{
	global.collect = 0;
	other.hp++;
}
if global.collect <= 20
	global.points += 10
instance_destroy();
