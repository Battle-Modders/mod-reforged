local units = [
	{
		ID = "Unit.NomadCutthroat",
		Troop = "NomadCutthroat",
		Figure = "figure_nomad_01",     // Official "Cutthroat" figure
		Cost = 12
	},
	{
		ID = "Unit.NomadSlinger",
		Troop = "NomadSlinger",
		Figure = "figure_nomad_03",     // Seems to be the "Slinger" figure but it may aswell not exist or be used for variations/other entities
		Cost = 12
	},
	{
		ID = "Unit.NomadOutlaw",
		Troop = "NomadOutlaw",
		Figure = "figure_nomad_02",     // Official "Outlaw" figure
		Cost = 25
	},
	{
		ID = "Unit.NomadArcher",
		Troop = "NomadArcher",
		Figure = "figure_nomad_04",
		Cost = 15
	},
	{
		ID = "Unit.NomadLeader",
		Troop = "NomadLeader",
		Figure = "figure_nomad_05",
		Cost = 30
	},
	{
		ID = "Unit.NomadDesertStalker",
		Troop = "DesertStalker",
		Figure = "figure_nomad_05",
		Cost = 40
	},
	{
		ID = "Unit.NomadExecutioner",
		Troop = "Executioner",
		Figure = "figure_nomad_05",
		Cost = 40
	},
	{
		ID = "Unit.NomadDesertDevil",
		Troop = "DesertDevil",
		Figure = "figure_nomad_05",
		Cost = 40
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
