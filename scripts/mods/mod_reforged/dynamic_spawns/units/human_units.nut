local units = [
// Civilians
	{
		ID = "Unit.Peasant",
		Troop = "Peasant",
		Cost = 10,
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.PeasantArmed",
		Troop = "PeasantArmed",
		Cost = 10,
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.SouthernPeasant",
		Troop = "SouthernPeasant",
		Cost = 10
	},
	{
		ID = "Unit.CultistAmbush",
		Troop = "CultistAmbush",
		Cost = 15,
		Figure = "figure_civilian_03"
	},
	{
		ID = "Unit.NorthernSlave",
		Troop = "NorthernSlave",
		Cost = 7
	},

// Caravans
	{
		ID = "Unit.CaravanHand",
		Troop = "CaravanHand",
		Cost = 10
	},
	{
		ID = "Unit.CaravanGuard",
		Troop = "CaravanGuard",
		Cost = 14
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
		Troop = "Militia",
		Cost = 10
	},
	{
		ID = "Unit.MilitiaRanged",
		Troop = "MilitiaRanged",
		Cost = 10
	},
	{
		ID = "Unit.MilitiaVeteran",
		Troop = "MilitiaVeteran",
		Cost = 15   // Vanilla 12
	},
	{
		ID = "Unit.MilitiaCaptain",
		Troop = "MilitiaCaptain",
		Cost = 20
	},

// Mercenaries
	{
		ID = "Unit.BountyHunter",
		Troop = "BountyHunter",
		Cost = 25
	},
	{
		ID = "Unit.BountyHunterRanged",
		Troop = "BountyHunterRanged",
		Cost = 20
	},
	{
		ID = "Unit.Wardog",
		Troop = "Wardog",
		Cost = 8
	},

	{
		ID = "Unit.MercenaryLOW",
		Troop = "MercenaryLOW",
		Cost = 18
	},
	{
		ID = "Unit.Mercenary",
		Troop = "Mercenary",
		Cost = 25
	},
	{
		ID = "Unit.MercenaryRanged",
		Troop = "MercenaryRanged",
		Cost = 25
	},
	{
		ID = "Unit.MasterArcher",
		Troop = "MasterArcher",
	},
	{
		ID = "Unit.HedgeKnight",
		Troop = "HedgeKnight",
	},
	{
		ID = "Unit.Swordmaster",
		Troop = "Swordmaster",
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
