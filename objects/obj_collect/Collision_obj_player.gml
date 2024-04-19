if ++global.collect >= 30 && obj_player.hp < 7
{
	global.collect = 0;
	other.hp++;
}
global.points += 10
instance_destroy();
