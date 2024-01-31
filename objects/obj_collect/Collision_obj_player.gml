if ++global.collect >= 20
{
	global.collect = 0;
	other.hp++;
}
global.points += 10
instance_destroy();
