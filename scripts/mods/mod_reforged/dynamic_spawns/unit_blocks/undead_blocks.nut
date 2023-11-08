local unitBlocks = [
	{
		ID = "UnitBlock.RF.SkeletonFrontline",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonLight" },
			{ BaseID = "Unit.RF.RF_SkeletonLightElite" },
			{ BaseID = "Unit.RF.SkeletonMedium" },
			{ BaseID = "Unit.RF.RF_SkeletonMediumElite" }
		]
	},
	{
		ID = "UnitBlock.RF_SkeletonBackline",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonLightElitePolearm" },
			{ BaseID = "Unit.RF.SkeletonMediumPolearm" },
			{ BaseID = "Unit.RF.RF_SkeletonMediumElitePolearm" }
		]
	},
	{
		ID = "UnitBlock.RF.SkeletonElite",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesser" },
			{ BaseID = "Unit.RF.SkeletonHeavy" }
		]
	},
	{
		ID = "UnitBlock.RF.SkeletonSupport",
		DeterminesFigure = true,
		IsRandom = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonPriestP", StartingResourceMax = 400 },
			{ BaseID = "Unit.RF.SkeletonPriestPP" },
			{ BaseID = "Unit.RF.SkeletonPriestPH" },
			{ BaseID = "Unit.RF.SkeletonPriestHH" }
		]
	},
	{
		ID = "UnitBlock.RF.Vampire",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.Vampire" },
			{ BaseID = "Unit.RF.RF_VampireLord", HardMax = 1 }
		]
	},
	{
		ID = "UnitBlock.RF.SkeletonDecanus",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonDecanus" }
		]
	},
	{
		ID = "UnitBlock.RF.SkeletonCenturion",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonCenturion" }
		]
	},
	{
		ID = "UnitBlock.RF.SkeletonLegatus",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonLegatus" }
		]
	}
];

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
