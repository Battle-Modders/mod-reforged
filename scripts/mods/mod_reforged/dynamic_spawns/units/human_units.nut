local units = [
// Civilians
	{
		ID = "Unit.Peasant",
		Troop = "Peasant",
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.PeasantArmed",
		Troop = "PeasantArmed",
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.SouthernPeasant",
		Troop = "SouthernPeasant"
	},
	{
		ID = "Unit.CultistAmbush",
		Troop = "CultistAmbush",
		Figure = "figure_civilian_03"
	},
	{
		ID = "Unit.NorthernSlave",
		Troop = "NorthernSlave"
	},

// Caravans
	{
		ID = "Unit.CaravanHand",
		Troop = "CaravanHand"
	},
	{
		ID = "Unit.CaravanGuard",
		Troop = "CaravanGuard"
	},
	{
		ID = "Unit.CaravanDonkey",
		Troop = "CaravanDonkey",
		Cost = 10,      // 0 in Vanilla
		Figure = "cart_02"
	},

// Militia
	{
		ID = "Unit.Militia",
		Troop = "Militia"
	},
	{
		ID = "Unit.MilitiaRanged",
		Troop = "MilitiaRanged"
	},
	{
		ID = "Unit.MilitiaVeteran",
		Troop = "MilitiaVeteran",
		Cost = 15   // Vanilla 12
	},
	{
		ID = "Unit.MilitiaCaptain",
		Troop = "MilitiaCaptain",
		Cost = 20,
		StartingResourceMin = 144	// In Vanilla they appear in a group of 144 cost
	},

// Mercenaries
	{
		ID = "Unit.BountyHunter",
		Troop = "BountyHunter"
	},
	{
		ID = "Unit.BountyHunterRanged",
		Troop = "BountyHunterRanged"
	},
	{
		ID = "Unit.Wardog",
		Troop = "Wardog"
	},

	{
		ID = "Unit.MercenaryLOW",
		Troop = "MercenaryLOW"
	},
	{
		ID = "Unit.Mercenary",
		Troop = "Mercenary"
	},
	{
		ID = "Unit.MercenaryRanged",
		Troop = "MercenaryRanged"
	},
	{
		ID = "Unit.MasterArcher",
		Troop = "MasterArcher",
		StartingResourceMin = 286	// In Vanilla MasterArcher appear in a group of 286 cost
	},
	{
		ID = "Unit.HedgeKnight",
		Troop = "HedgeKnight",
		StartingResourceMin = 286	// In Vanilla MasterArcher appear in a group of 286 cost
	},
	{
		ID = "Unit.Swordmaster",
		Troop = "Swordmaster",
		StartingResourceMin = 286	// In Vanilla MasterArcher appear in a group of 286 cost
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
