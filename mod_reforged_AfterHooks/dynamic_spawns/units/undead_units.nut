local units = [
	// Changes to DSF defined units
	{
		ID = "Unit.RF.SkeletonLight",
		Troop = "SkeletonLight",
		Figure = "figure_rf_skeleton_light"
	},
	{
		ID = "Unit.RF.SkeletonMedium",
		Troop = "SkeletonMedium",
		Figure = "figure_rf_skeleton_medium",
		StartingResourceMin = 180
	},
	{
		ID = "Unit.RF.SkeletonMediumPolearm",
		Troop = "SkeletonMediumPolearm",
		Figure = "figure_rf_skeleton_medium",
		StartingResourceMin = 180
	},
	{
		ID = "Unit.RF.SkeletonHeavy",
		Troop = "SkeletonHeavy",
		Figure = "figure_skeleton_03",
		StartingResourceMin = 300
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
		StartingResourceMin = 225
	},

	//New in Reforged
	{
		ID = "Unit.RF.RF_SkeletonLightElite",
		Troop = "RF_SkeletonLightElite",
		Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 120
	},
	{
		ID = "Unit.RF.RF_SkeletonLightElitePolearm",
		Troop = "RF_SkeletonLightElitePolearm",
		Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 120
	},
	{
		ID = "Unit.RF.RF_SkeletonMediumElite",
		Troop = "RF_SkeletonMediumElite",
		Figure = "figure_rf_skeleton_medium_elite",
		StartingResourceMin = 240
	},
	{
		ID = "Unit.RF.RF_SkeletonMediumElitePolearm",
		Troop = "RF_SkeletonMediumElitePolearm",
		Figure = "figure_rf_skeleton_medium_elite",
		StartingResourceMin = 240
	},
	{
		ID = "Unit.RF.RF_SkeletonHeavyLesser",
		Troop = "RF_SkeletonHeavyLesser",
		Figure = "figure_rf_skeleton_heavy_lesser",
		StartingResourceMin = 220
	},
	{
		ID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard",
		Troop = "RF_SkeletonHeavyLesserBodyguard",
		Figure = "figure_rf_skeleton_heavy_lesser",
		StartingResourceMin = 220
	},
	{
		ID = "Unit.RF.RF_VampireLord",
		Troop = "RF_VampireLord",
		Figure = "figure_rf_vampire_lord",
		StartingResourceMin = 300
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
		Figure = "figure_rf_skeleton_centurion"
	},
	{
		ID = "Unit.RF.RF_SkeletonLegatus",
		Troop = "RF_SkeletonLegatus",
		Figure = "figure_rf_skeleton_legatus",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.SkeletonPriest",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.SkeletonPriestP",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		StartingResourceMin = 300,
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
	::DynamicSpawns.Public.registerUnit(unitDef);
}
