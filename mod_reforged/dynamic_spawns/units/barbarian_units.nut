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
		StartingResourceMin = 75 // Vanilla is 73 in "Barbarians" party
	},
	{
		ID = "Unit.RF.BarbarianChampion",
		Troop = "BarbarianChampion",
		Figure = "figure_wildman_03",
		StartingResourceMin = 160 // Vanilla is 160 in "Barbarians" party
	},
	{
		ID = "Unit.RF.BarbarianDrummer",
		Troop = "BarbarianDrummer",
		StartingResourceMin = 170 // Vanilla is 168 in "Barbarians" party
	},
	{
		ID = "Unit.RF.BarbarianChosen",
		Troop = "BarbarianChosen",		// This is the Barbarian King. Weird Vanilla Naming Scheme
		Figure = "figure_wildman_04"
	},
	{
		ID = "Unit.RF.Warhound",
		Troop = "Warhound"
	},
	{
		ID = "Unit.RF.BarbarianUnhold",
		Troop = "BarbarianUnhold",
		Figure = "figure_unhold_01"	 // Not really needed as barbarian unholds never determine their Figure in Vanilla
	},
	{
		ID = "Unit.RF.BarbarianUnholdFrost",
		Troop = "BarbarianUnholdFrost",
		Figure = "figure_unhold_02"	 // Not really needed as barbarian unholds never determine their Figure in Vanilla
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterU",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		StartingResourceMin = 200, // In Vanilla they appear in a group of 195 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "OneUnhold" }
			]
		}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterUU",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		StartingResourceMin = 400, // In Vanilla they appear in a group of 400 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "TwoUnhold" }
			]
		}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		StartingResourceMin = 200, // In Vanilla they appear in a group of 195 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "OneFrostUnhold" }
			]
		}
	},
	{
		ID = "Unit.RF.BarbarianBeastmasterFF",
		Troop = "BarbarianBeastmaster",	// Usually it's 1 Beastmaster for 1-2 Unholds. In one case vanilla spawns 3 Unholds for one Beastmaster. And in one case Vanilla spawns 3 Beastmaster for 4 Unholds. I would disregard these.
		StartingResourceMin = 430, // In Vanilla they appear in a group of 430 cost
		StaticDefs = {
			Parties = [
				{ BaseID = "TwoFrostUnhold" }
			]
		}
	}
];

foreach (unitDef in units)
{
	::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
}
