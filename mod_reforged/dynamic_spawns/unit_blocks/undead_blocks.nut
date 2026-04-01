local unitBlocks = [
	{
		ID = "UnitBlock.RF.SkeletonFrontline",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonLight" },
				{ BaseID = "Unit.RF.SkeletonMedium" },
				{ BaseID = "Unit.RF.RF_SkeletonMediumElite" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonBackline",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonMediumPolearm" },
				{ BaseID = "Unit.RF.RF_SkeletonMediumElitePolearm" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonElite",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonHeavy" }
				{ BaseID = "Unit.RF.RF_SkeletonHeavyElite" },
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonSupport",
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
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.Vampire" },
				{ BaseID = "Unit.RF.RF_VampireLord", Cost = ::Const.World.Spawn.Troops.Vampire.Cost * 2, HardMax = 2 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.Vampire",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.Vampire" },
				{ BaseID = "Unit.RF.RF_VampireLord", HardMax = 1 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonDecanus",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonDecanus" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonCenturion",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonCenturion" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.SkeletonLegatus",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonLegatus" }
			]
		}
	}
];

foreach (blockDef in unitBlocks)
{
	::Reforged.Spawns.UnitBlocks[blockDef.ID] <- blockDef;
}
