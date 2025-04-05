local units = [
	{
		ID = "Unit.RF.Conscript",
		Troop = "Conscript",
		Figure = "figure_southern_01"
	},
	{
		ID = "Unit.RF.Conscript_Polearm",
		Troop = "ConscriptPolearm"
	},
	{
		ID = "Unit.RF.Officer",
		Troop = "Officer",
		Figure = "figure_southern_02",
		StartingResourceMin = 280 // In Vanilla they appear in a group of 250 cost
	},
	{
		ID = "Unit.RF.Gunner",
		Troop = "Gunner"
	},
	{
		ID = "Unit.RF.Engineer",
		Troop = "Engineer"
	},
	{
		ID = "Unit.RF.Mortar",
		Troop = "Mortar",
		StartingResourceMin = 340, // In Vanilla they appear in a group of 340 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "MortarEngineers", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.Assassin",
		Troop = "Assassin"
		StartingResourceMin = 250
	},
	{
		ID = "Unit.RF.Slave",
		Troop = "Slave"
	},

// Caravans
	{
		ID = "Unit.RF.SouthernDonkey",
		Troop = "SouthernDonkey",
		Figure = "cart_03",
		Cost = 10	// 0 in Vanilla
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
