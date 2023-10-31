local units = [
	{
		ID = "Unit.SouthernConscript",
		Troop = "Conscript",
		Cost = 20,
		Figure = "figure_southern_01"
	},
	{
		ID = "Unit.SouthernConscript_Polearm",
		Troop = "ConscriptPolearm",
		Cost = 15
	},
	{
		ID = "Unit.SouthernOfficer",
		Troop = "Officer",
		Cost = 25,
		Figure = "figure_southern_02"
	},
	{
		ID = "Unit.SouthernGunner",
		Troop = "Gunner",
		Cost = 20
	},
	{
		ID = "Unit.SouthernEngineer",
		Troop = "Engineer",
		Cost = 10
	},
	{
		ID = "Unit.SouthernMortar",
		Troop = "Mortar",
		Cost = 20,
		SubPartyDef = {ID = "MortarEngineers"}
	},
	{
		ID = "Unit.SouthernAssassin",
		Troop = "Assassin",
		Cost = 35
	},
	{
		ID = "Unit.SouthernSlave",
		Troop = "Slave",
		Cost = 7
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
