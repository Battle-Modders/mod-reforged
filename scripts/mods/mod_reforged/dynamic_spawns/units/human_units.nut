local units = [
// Civilians
	// {
	// 	ID = "Human.Peasant",
	// 	Troop = "Peasant",
	// 	Cost = 10,
	// 	Figure = "figure_civilian_01"
	// },
	// {
	// 	ID = "Human.PeasantArmed",
	// 	Troop = "PeasantArmed",
	// 	Cost = 10,
	// 	Figure = "figure_civilian_01"
	// },
	// {
	// 	ID = "Human.SouthernPeasant",
	// 	Troop = "SouthernPeasant",
	// 	Cost = 10
	// },
	// {
	// 	ID = "Human.CultistAmbush",
	// 	Troop = "CultistAmbush",
	// 	Cost = 15,
	// 	Figure = "figure_civilian_03"
	// },
	// {
	// 	ID = "Human.Slave",
	// 	Troop = "NorthernSlave",
	// 	Cost = 7
	// },

// Caravans
	// {
	// 	ID = "Human.CaravanHand",
	// 	Troop = "CaravanHand",
	// 	Cost = 10
	// },
	// {
	// 	ID = "Human.CaravanGuard",
	// 	Troop = "CaravanGuard",
	// 	Cost = 14
	// },
	// {
	// 	ID = "Human.CaravanDonkey",
	// 	Troop = "CaravanDonkey",
	// 	Cost = 10,      // 0 in Vanilla
	// 	Figure = "cart_02"
	// },

// Militia
	// {
	// 	ID = "Human.Militia",
	// 	Troop = "Militia",
	// 	Cost = 10
	// },
	// {
	// 	ID = "Human.MilitiaRanged",
	// 	Troop = "MilitiaRanged",
	// 	Cost = 10
	// },
	// {
	// 	ID = "Human.MilitiaVeteran",
	// 	Troop = "MilitiaVeteran",
	// 	Cost = 15   // Vanilla 12
	// },
	// {
	// 	ID = "Human.MilitiaCaptain",
	// 	Troop = "MilitiaCaptain",
	// 	Cost = 20
	// },

// Mercenaries
	// {
	// 	ID = "Human.BountyHunter",
	// 	Troop = "BountyHunter",
	// 	Cost = 25
	// },
	// {
	// 	ID = "Human.BountyHunterRanged",
	// 	Troop = "BountyHunterRanged",
	// 	Cost = 20
	// },
	// {
	// 	ID = "Human.ArmoredWardog",
	// 	Troop = "ArmoredWardog",
	// 	Cost = 9
	// },
	// {
	// 	ID = "Human.MercenaryLOW",
	// 	Troop = "MercenaryLOW",
	// 	Cost = 18
	// },
	// {
	// 	ID = "Human.Mercenary",
	// 	Troop = "Mercenary",
	// 	Cost = 25
	// },
	// {
	// 	ID = "Human.MercenaryRanged",
	// 	Troop = "MercenaryRanged",
	// 	Cost = 25
	// },
	{
		ID = "Human.MasterArcher",
		Troop = "MasterArcher"
	},
	{
		ID = "Human.HedgeKnight",
		Troop = "HedgeKnight"
	},
	{
		ID = "Human.Swordmaster",
		Troop = "Swordmaster"
	}
]

/*
While there are ["figure_militia_01", "figure_militia_02"] it seems like they are just variations of the same tier of figure and interchangable.
*/

foreach (unitDef in units)
{
	unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
