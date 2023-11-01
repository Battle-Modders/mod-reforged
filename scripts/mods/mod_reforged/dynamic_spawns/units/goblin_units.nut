local units = [
	{
		ID = "Unit.RF.GoblinSkirmisherLOW",
		Troop = "GoblinSkirmisherLOW",
		Figure = "figure_goblin_01"
	},
	{
		ID = "Unit.RF.GoblinSkirmisher",
		Troop = "GoblinSkirmisher",
		Figure = "figure_goblin_01"
	},
	{
		ID = "Unit.RF.GoblinAmbusherLOW",
		Troop = "GoblinAmbusherLOW",
		Figure = "figure_goblin_02"
	},
	{
		ID = "Unit.RF.GoblinAmbusher",
		Troop = "GoblinAmbusher",
		Figure = "figure_goblin_02"
	},
	{
		ID = "Unit.RF.GoblinWolfrider",
		Troop = "GoblinWolfrider",
		Figure = "figure_goblin_05"
	},
	{
		ID = "Unit.RF.GoblinOverseer",
		Troop = "GoblinOverseer",
		Figure = "figure_goblin_04"
	},
	{
		ID = "Unit.RF.GoblinShaman",
		Troop = "GoblinShaman",
		Figure = "figure_goblin_03"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
