local unitBlocks = [
	{
		ID = "UnitBlock.RF.SkeletonFrontline",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonLight" },
				{ BaseID = "Unit.RF.RF_SkeletonLightElite" },
				{ BaseID = "Unit.RF.SkeletonMedium" },
				{ BaseID = "Unit.RF.RF_SkeletonMediumElite" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonBackline",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonLightElitePolearm" },  // added for balanced spawns and upgrading compared to Frontline
				{ BaseID = "Unit.RF.RF_SkeletonLightElitePolearm" },
				{ BaseID = "Unit.RF.SkeletonMediumPolearm" },
				{ BaseID = "Unit.RF.RF_SkeletonMediumElitePolearm" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonElite",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonHeavyLesser" },
				{ BaseID = "Unit.RF.SkeletonHeavy" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonSupport",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonPriestP", StartingResourceMax = 400 },
				{ BaseID = "Unit.RF.SkeletonPriestPP" },
				{ BaseID = "Unit.RF.SkeletonPriestPH" },
				{ BaseID = "Unit.RF.SkeletonPriestHH" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.VampireOnly",  // VampireOnly party created to solve Vampire Lords always spawning at certain resource intervals
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.Vampire" },
				{ BaseID = "Unit.RF.RF_VampireLord", Cost = ::Const.World.Spawn.Troops.Vampire.Cost * 2, HardMax = 2 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.Vampire",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.Vampire" },
				{ BaseID = "Unit.RF.RF_VampireLord", HardMax = 1 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonDecanus",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonDecanus" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonCenturion",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonCenturion" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonLegatus",
		DeterminesFigure = true,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonLegatus" }
			]
		}
	}
];

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
