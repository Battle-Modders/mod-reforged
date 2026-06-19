// We disable the chance for BrigandMarauders to appear
// We utilize dynamic parties instead to guarantee tiering and variety
::Const.World.Scaling.Brigands.GetMarauderSpawnChance = { function GetMarauderSpawnChance ( _days ) {
	return 0;
}}.GetMarauderSpawnChance;
