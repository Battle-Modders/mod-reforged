local units = [
	{
		ID = "Unit.RF.OrcYoung",
		Troop = "OrcYoung",
		Figure = ["figure_orc_02", "figure_orc_06"]		// I assume this is OrcYoung only with Helmet (02) and OrcYoung only with Armor (06)
	},
	{
		ID = "Unit.RF.OrcBerserker",
		Troop = "OrcBerserker",
		Figure = "figure_orc_03"		// I'm sure this is OrcBerserker
	},
	{
		ID = "Unit.RF.OrcWarrior",
		Troop = "OrcWarrior",
		Figure = "figure_orc_04"		// I'm sure this is OrcWarrior
	},
	{
		ID = "Unit.RF.OrcWarlord",
		Troop = "OrcWarlord",
		Figure = "figure_orc_05"		// I'm sure this is OrcWarlord
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
