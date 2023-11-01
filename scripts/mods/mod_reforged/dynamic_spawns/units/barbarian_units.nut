local units = [
	{
		ID = "Unit.RF.BarbarianThrall",
		Troop = "BarbarianThrall",
		Figure = "figure_wildman_01"
	},
	{
		ID = "Unit.RF.BarbarianMarauder",
		Troop = "BarbarianMarauder",
		Figure = "figure_wildman_02"
	},
	{
		ID = "Unit.RF.BarbarianChosen",
		Troop = "BarbarianChampion",
		Figure = "figure_wildman_03",
		StartingResourceMin = 170
	},
	{
		ID = "Unit.RF.BarbarianDrummer",
		Troop = "BarbarianDrummer",
		StartingResourceMin = 200 // In Vanilla they start appearing in a group of 210 cost alongside 15 thralls
	},
	{
		ID = "Unit.RF.BarbarianKing",
		Troop = "BarbarianChosen",		// Weird Vanilla Naming Scheme
		Figure = "figure_wildman_06"
	},
	{
		ID = "Unit.RF.BarbarianWarhound",
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
		SubPartyDef = {ID = "OneUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterUU",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 55 + 55,
		SubPartyDef = {ID = "TwoUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 75,
		SubPartyDef = {ID = "OneFrostUnhold"}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterFF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		Cost = 15 + 75 + 75,
		SubPartyDef = {ID = "TwoFrostUnhold"}
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
