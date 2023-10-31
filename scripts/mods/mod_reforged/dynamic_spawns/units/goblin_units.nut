local units = [
	{
		ID = "Unit.GoblinSkirmisherLOW",
		Troop = "GoblinSkirmisherLOW",
		Figure = "figure_goblin_01",
		Cost = 10
	},
	{
		ID = "Unit.GoblinSkirmisher",
		Troop = "GoblinSkirmisher",
		Figure = "figure_goblin_01",
		Cost = 15
	},
	{
		ID = "Unit.GoblinAmbusherLOW",
		Troop = "GoblinAmbusherLOW",
		Figure = "figure_goblin_02",
		Cost = 15
	},
	{
		ID = "Unit.GoblinAmbusher",
		Troop = "GoblinAmbusher",
		Figure = "figure_goblin_02",
		Cost = 20
	},
	{
		ID = "Unit.GoblinWolfrider",
		Troop = "GoblinWolfrider",
		Figure = "figure_goblin_05",
		Cost = 20
	},
	{
		ID = "Unit.GoblinOverseer",
		Troop = "GoblinOverseer",
		Figure = "figure_goblin_04",
		Cost = 35
	},
	{
		ID = "Unit.GoblinShaman",
		Troop = "GoblinShaman",
		Figure = "figure_goblin_03",
		Cost = 35
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
