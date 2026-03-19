local units = [
	// Changes to DSF defined units
	{
		ID = "Unit.RF.SkeletonLight",
		Troop = "SkeletonLight",
		Figure = "figure_skeleton_01"
	},
	{
		ID = "Unit.RF.SkeletonMedium",
		Troop = "SkeletonMedium",
		Figure = "figure_skeleton_02",
		StartingResourceMin = 140 // Vanilla is 138 in "UndeadArmy" party
	},
	{
		ID = "Unit.RF.SkeletonMediumPolearm",
		Troop = "SkeletonMediumPolearm",
		Figure = "figure_skeleton_02",
		StartingResourceMin = 155 // Vanilla is 155 in "UndeadArmy" party
	},
	{
		ID = "Unit.RF.SkeletonHeavy",
		Troop = "SkeletonHeavy",
		Figure = "figure_skeleton_03",
		StartingResourceMin = 205 // Vanilla is 205 in "UndeadArmy" party
	},
	{
		ID = "Unit.RF.SkeletonHeavyBodyguard",
		Troop = "SkeletonHeavyBodyguard",
		Figure = "figure_skeleton_03"
	},
	{
		ID = "Unit.RF.Vampire",
		Troop = "Vampire"
	},
	{
		ID = "Unit.RF.SkeletonPriest",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 325 // Vanilla is 325 in "UndeadArmy" party
	},

	//New in Reforged
	{
		ID = "Unit.RF.RF_SkeletonMediumElite",
		Troop = "RF_SkeletonMediumElite",
		Figure = "figure_rf_skeleton_medium_elite",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.RF.RF_SkeletonMediumElitePolearm",
		Troop = "RF_SkeletonMediumElitePolearm",
		Figure = "figure_rf_skeleton_medium_elite",
		StartingResourceMin = 220
	},
	{
		ID = "Unit.RF.RF_SkeletonHeavyElite",
		Troop = "RF_SkeletonHeavyElite",
		Figure = "figure_rf_skeleton_heavy_elite",
		StartingResourceMin = 250
	},
	{
		ID = "Unit.RF.RF_SkeletonHeavyEliteBodyguard",
		Troop = "RF_SkeletonHeavyEliteBodyguard",
		Figure = "figure_rf_skeleton_heavy_lesser",
		StartingResourceMin = 250
	},
	{
		ID = "Unit.RF.RF_VampireLord",
		Troop = "RF_VampireLord",
		Figure = "figure_rf_vampire_lord",
		StartingResourceMin = 290
	},
	{
		ID = "Unit.RF.RF_SkeletonDecanus",
		Troop = "RF_SkeletonDecanus",
		Figure = "figure_rf_skeleton_decanus",
		StartingResourceMin = 180
	},
	{
		ID = "Unit.RF.RF_SkeletonCenturion",
		Troop = "RF_SkeletonCenturion",
		Figure = "figure_rf_skeleton_centurion",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_SkeletonLegatus",
		Troop = "RF_SkeletonLegatus",
		Figure = "figure_rf_skeleton_legatus",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.SkeletonPriestP",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 300,
		Cost = 40,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyPrae", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.SkeletonPriestPP",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 325,
		Cost = 40,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyPrae2", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.SkeletonPriestPH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 350,
		Cost = 40,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyPraeHonor", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.SkeletonPriestHH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 375,
		Cost = 40,
		StaticDefs = {
			Parties = [
				{ BaseID = "SubPartyHonor2", IsUsingTopPartyResources = false }
			]
		}
	}
];

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
}
