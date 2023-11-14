local units = [
	{
		ID = "Unit.RF.BarbarianThrall",
		Troop = "BarbarianThrall",
		Figure = "figure_wildman_01"
	},
	{
		ID = "Unit.RF.BarbarianMarauder",
		Troop = "BarbarianMarauder",
		Figure = "figure_wildman_02",
		StartingResourceMin = 125
	},
	{
		ID = "Unit.RF.BarbarianChampion",
		Troop = "BarbarianChampion",
		Figure = "figure_wildman_03",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.RF.BarbarianDrummer",
		Troop = "BarbarianDrummer",
		StartingResourceMin = 200 // In Vanilla they start appearing in a group of 210 cost alongside 15 thralls
	},
	{
		ID = "Unit.RF.BarbarianChosen",
		Troop = "BarbarianChosen",		// This is the Barbarian King. Weird Vanilla Naming Scheme
		Figure = "figure_wildman_06"
	},
	{
		ID = "Unit.RF.Warhound",
		Troop = "Warhound"
	},
	{
		ID = "Unit.RF.BarbarianUnhold",
		Troop = "BarbarianUnhold",
		Figure = "figure_unhold_01"     // Not really needed as barbarian unholds never determine their Figure in Vanilla
	},
	{
		ID = "Unit.RF.BarbarianUnholdFrost",
		Troop = "BarbarianUnholdFrost",
		Figure = "figure_unhold_02"     // Not really needed as barbarian unholds never determine their Figure in Vanilla
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterU",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 55,
		StartingResourceMin = 200, // In Vanilla they appear in a group of 195 cost
		SubPartyDef = {BaseID = "OneUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterUU",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 55 + 55,
		StartingResourceMin = 400, // In Vanilla they appear in a group of 400 cost
		SubPartyDef = {BaseID = "TwoUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 75,
		StartingResourceMin = 200, // In Vanilla they appear in a group of 195 cost
		SubPartyDef = {BaseID = "OneFrostUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterFF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 75 + 75,
		StartingResourceMin = 430, // In Vanilla they appear in a group of 430 cost
		SubPartyDef = {BaseID = "TwoFrostUnhold"}
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
