local units = [
	{
		ID = "Unit.OrcYoungLOW",
		Troop = "OrcYoungLOW",
		Figure = "figure_orc_01",       // I assume this is OrcYoung without Armor and without Helmet
		Cost = 13
	},
	{
		ID = "Unit.OrcYoung",
		Troop = "OrcYoung",
		Figure = ["figure_orc_02", "figure_orc_06"],       // I assume this is OrcYoung only with Helmet (02) and OrcYoung only with Armor (06)
		Cost = 16
	},
	{
		ID = "Unit.OrcBerserker",
		Troop = "OrcBerserker",
		Figure = "figure_orc_03"        // I'm sure this is OrcBerserker
		Cost = 25
	},
	{
		ID = "Unit.OrcWarriorLOW",
		Troop = "OrcWarriorLOW",
		Figure = "figure_orc_04"        // I'm sure this is OrcWarrior
		Cost = 30
	},
	{
		ID = "Unit.OrcWarrior",
		Troop = "OrcWarrior",
		Figure = "figure_orc_04",       // I'm sure this is OrcWarrior
		Cost = 40
	},
	{
		ID = "Unit.OrcWarlord",
		Troop = "OrcWarlord",
		Figure = "figure_orc_05",       // I'm sure this is OrcWarlord
		Cost = 50
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
