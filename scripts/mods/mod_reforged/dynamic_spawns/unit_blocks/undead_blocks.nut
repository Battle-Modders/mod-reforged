local unitBlocks = [
	{
			ID = "UnitBlock.RF.UndeadFrontline",
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonLight" },
			{ BaseID = "Unit.RF.SkeletonMedium" },
			{ BaseID = "Unit.RF.SkeletonHeavy" }
		]
	},
	{
			ID = "UnitBlock.RF.UndeadBackline",
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonMediumPolearm" },
			{ BaseID = "Unit.RF.SkeletonHeavyPolearm" }
		]
	},
	{
			ID = "UnitBlock.RF.UndeadBoss",
			StartingResourceMin = 225
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonPriestH" },
			{ BaseID = "Unit.RF.SkeletonPriestHH" }
		]
	},
	{
			ID = "UnitBlock.RF.SkeletonHeavyBodyguard",
		UnitDefs = [
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
		]
	},
	{
			ID = "UnitBlock.RF.Vampire",
		UnitDefs = [
			{ BaseID = "Unit.RF.VampireLOW" },
			{ BaseID = "Unit.RF.Vampire" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
