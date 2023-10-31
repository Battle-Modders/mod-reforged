local units = [
	{
		ID = "Unit.Conscript",
		Troop = "Conscript",
		Figure = "figure_southern_01"
	},
	{
		ID = "Unit.Conscript_Polearm",
		Troop = "ConscriptPolearm"
	},
	{
		ID = "Unit.Officer",
		Troop = "Officer",
		Figure = "figure_southern_02",
		StartingResourceMin = 250 // In Vanilla they appear in a group of 250 cost
	},
	{
		ID = "Unit.Gunner",
		Troop = "Gunner"
	},
	{
		ID = "Unit.Engineer",
		Troop = "Engineer"
	},
	{
		ID = "Unit.Mortar",
		Troop = "Mortar",
		StartingResourceMin = 340, // In Vanilla they appear in a group of 340 cost
		SubPartyDef = {ID = "MortarEngineers"}
	},
	{
		ID = "Unit.Assassin",
		Troop = "Assassin"
	},
	{
		ID = "Unit.Slave",
		Troop = "Slave"
	},

// Caravans
	{
		ID = "Unit.SouthernCaravanDonkey",
		Troop = "SouthernDonkey",
		Figure = "cart_02",
		Cost = 10      // 0 in Vanilla
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
