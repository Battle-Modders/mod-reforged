local units = [
	{
		ID = "Unit.NomadCutthroat",
		Troop = "NomadCutthroat",
		Figure = "figure_nomad_01"     // Official "Cutthroat" figure
	},
	{
		ID = "Unit.NomadSlinger",
		Troop = "NomadSlinger",
		Figure = "figure_nomad_03"     // Seems to be the "Slinger" figure but it may aswell not exist or be used for variations/other entities
	},
	{
		ID = "Unit.NomadOutlaw",
		Troop = "NomadOutlaw",
		Figure = "figure_nomad_02"     // Official "Outlaw" figure
	},
	{
		ID = "Unit.NomadArcher",
		Troop = "NomadArcher",
		Figure = "figure_nomad_04"
	},
	{
		ID = "Unit.NomadLeader",
		Troop = "NomadLeader",
		Figure = "figure_nomad_05"
	},
	{
		ID = "Unit.NomadDesertStalker",
		Troop = "DesertStalker",
		Figure = "figure_nomad_05"
	},
	{
		ID = "Unit.NomadExecutioner",
		Troop = "Executioner",
		Figure = "figure_nomad_05"
	},
	{
		ID = "Unit.NomadDesertDevil",
		Troop = "DesertDevil",
		Figure = "figure_nomad_05"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
