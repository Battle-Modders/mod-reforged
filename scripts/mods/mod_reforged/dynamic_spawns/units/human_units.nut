local units = [
// Civilians
	{
		ID = "Unit.RF.Peasant",
		Troop = "Peasant",
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.RF.PeasantArmed",
		Troop = "PeasantArmed",
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.RF.SouthernPeasant",
		Troop = "SouthernPeasant"
	},
	{
		ID = "Unit.RF.CultistAmbush",
		Troop = "CultistAmbush",
		Figure = "figure_civilian_03"
	},
	{
		ID = "Unit.RF.NorthernSlave",
		Troop = "NorthernSlave"
	},

// Caravans
	{
		ID = "Unit.RF.CaravanHand",
		Troop = "CaravanHand"
	},
	{
		ID = "Unit.RF.CaravanGuard",
		Troop = "CaravanGuard"
	},
	{
		ID = "Unit.RF.CaravanDonkey",
		Troop = "CaravanDonkey",
		Cost = 10,      // 0 in Vanilla
		Figure = "cart_02"
	},

// Militia
	{
		ID = "Unit.RF.Militia",
		Troop = "Militia"
	},
	{
		ID = "Unit.RF.MilitiaRanged",
		Troop = "MilitiaRanged"
	},
	{
		ID = "Unit.RF.MilitiaVeteran",
		Troop = "MilitiaVeteran",
		Cost = 15   // Vanilla 12
	},
	{
		ID = "Unit.RF.MilitiaCaptain",
		Troop = "MilitiaCaptain",
		Cost = 20,
		StartingResourceMin = 144	// In Vanilla they appear in a group of 144 cost
	},

// Mercenaries
	{
		ID = "Unit.RF.BountyHunter",
		Troop = "BountyHunter"
	},
	{
		ID = "Unit.RF.BountyHunterRanged",
		Troop = "BountyHunterRanged"
	},
	{
		ID = "Unit.RF.Wardog",
		Troop = "Wardog"
	},
	{
		ID = "Unit.RF.Mercenary",
		Troop = "Mercenary"
	},
	{
		ID = "Unit.RF.MercenaryRanged",
		Troop = "MercenaryRanged"
	},
	{
		ID = "Unit.RF.MasterArcher",
		Troop = "MasterArcher",
		StartingResourceMin = 286	// In Vanilla they appear in a group of 286 cost
	},
	{
		ID = "Unit.RF.HedgeKnight",
		Troop = "HedgeKnight",
		StartingResourceMin = 286	// In Vanilla they appear in a group of 286 cost
	},
	{
		ID = "Unit.RF.Swordmaster",
		Troop = "Swordmaster",
		StartingResourceMin = 286	// In Vanilla they appear in a group of 286 cost
	}
]

/*
While there are ["figure_militia_01", "figure_militia_02"] it seems like they are just variations of the same tier of figure and interchangable.
*/

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
