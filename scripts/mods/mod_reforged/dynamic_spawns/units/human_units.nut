local units = [
// Civilians
	{
		ID = "Unit.HumanPeasant",
		Troop = "Peasant",
		Cost = 10,
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.HumanPeasantArmed",
		Troop = "PeasantArmed",
		Cost = 10,
		Figure = "figure_civilian_01"
	},
	{
		ID = "Unit.HumanSouthernPeasant",
		Troop = "SouthernPeasant",
		Cost = 10
	},
	{
		ID = "Unit.HumanCultistAmbush",
		Troop = "CultistAmbush",
		Cost = 15,
		Figure = "figure_civilian_03"
	},
	{
		ID = "Unit.HumanSlave",
		Troop = "NorthernSlave",
		Cost = 7
	},

// Caravans
	{
		ID = "Unit.HumanCaravanHand",
		Troop = "CaravanHand",
		Cost = 10
	},
	{
		ID = "Unit.HumanCaravanGuard",
		Troop = "CaravanGuard",
		Cost = 14
	},
	{
		ID = "Unit.HumanCaravanDonkey",
		Troop = "CaravanDonkey",
		Cost = 10,      // 0 in Vanilla
		Figure = "cart_02"
	},

// Militia
	{
		ID = "Unit.HumanMilitia",
		Troop = "Militia",
		Cost = 10
	},
	{
		ID = "Unit.HumanMilitiaRanged",
		Troop = "MilitiaRanged",
		Cost = 10
	},
	{
		ID = "Unit.HumanMilitiaVeteran",
		Troop = "MilitiaVeteran",
		Cost = 15   // Vanilla 12
	},
	{
		ID = "Unit.HumanMilitiaCaptain",
		Troop = "MilitiaCaptain",
		Cost = 20
	},

// Mercenaries
	{
		ID = "Unit.HumanBountyHunter",
		Troop = "BountyHunter",
		Cost = 25
	},
	{
		ID = "Unit.HumanBountyHunterRanged",
		Troop = "BountyHunterRanged",
		Cost = 20
	},
	{
		ID = "Unit.HumanWardog",
		Troop = "Wardog",
		Cost = 8
	},

	{
		ID = "Unit.HumanMercenaryLOW",
		Troop = "MercenaryLOW",
		Cost = 18
	},
	{
		ID = "Unit.HumanMercenary",
		Troop = "Mercenary",
		Cost = 25
	},
	{
		ID = "Unit.HumanMercenaryRanged",
		Troop = "MercenaryRanged",
		Cost = 25
	},
	{
		ID = "Unit.HumanMasterArcher",
		Troop = "MasterArcher",
	},
	{
		ID = "Unit.HumanHedgeKnight",
		Troop = "HedgeKnight",
	},
	{
		ID = "Unit.HumanSwordmaster",
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
