local unitBlocks = [
	{
			ID = "UnitBlock.UndeadFrontline",
		UnitDefs = [
			{ BaseID = "unit.SkeletonLight" },
			{ BaseID = "unit.SkeletonMedium" },
			{ BaseID = "unit.SkeletonHeavy" }
		]
	},
	{
			ID = "UnitBlock.UndeadBackline",
		UnitDefs = [
			{ BaseID = "unit.SkeletonMediumPolearm" },
			{ BaseID = "unit.SkeletonHeavyPolearm" }
		]
	},
	{
			ID = "UnitBlock.UndeadBoss",
			StartingResourceMin = 225
		UnitDefs = [
			{ BaseID = "unit.SkeletonPriestH" },
			{ BaseID = "unit.SkeletonPriestHH" }
		]
	},
	{
			ID = "UnitBlock.SkeletonHeavyBodyguard",
		UnitDefs = [
			{ BaseID = "unit.SkeletonHeavyBodyguard" }
		]
	},
	{
			ID = "UnitBlock.Vampire",
		UnitDefs = [
			{ BaseID = "unit.VampireLOW" },
			{ BaseID = "unit.Vampire" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
