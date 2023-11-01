local units = [
	{
		ID = "Unit.RF.NomadCutthroat",
		Troop = "NomadCutthroat",
		Figure = "figure_nomad_01"     // Official "Cutthroat" figure
	},
	{
		ID = "Unit.RF.NomadSlinger",
		Troop = "NomadSlinger",
		Figure = "figure_nomad_03"     // Seems to be the "Slinger" figure but it may aswell not exist or be used for variations/other entities
	},
	{
		ID = "Unit.RF.NomadOutlaw",
		Troop = "NomadOutlaw",
		Figure = "figure_nomad_02"     // Official "Outlaw" figure
	},
	{
		ID = "Unit.RF.NomadArcher",
		Troop = "NomadArcher",
		Figure = "figure_nomad_04"
	},
	{
		ID = "Unit.RF.NomadLeader",
		Troop = "NomadLeader",
		Figure = "figure_nomad_05",
		StartingResourceMin = 170 // In Vanilla they appear in a group of 170 cost
	},
	{
		ID = "Unit.RF.NomadDesertStalker",
		Troop = "DesertStalker",
		Figure = "figure_nomad_05",
		StartingResourceMin = 350	// In Vanilla Executioner appear in a group of 350 cost
	},
	{
		ID = "Unit.RF.NomadExecutioner",
		Troop = "Executioner",
		Figure = "figure_nomad_05",
		StartingResourceMin = 350	// In Vanilla Executioner appear in a group of 350 cost
	},
	{
		ID = "Unit.RF.NomadDesertDevil",
		Troop = "DesertDevil",
		Figure = "figure_nomad_05",
		StartingResourceMin = 350	// In Vanilla Executioner appear in a group of 350 cost
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
