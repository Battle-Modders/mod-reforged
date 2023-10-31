local unitBlocks = [
	{
			ID = "UnitBlock.UndeadFrontline",
		UnitDefs = [
			{ BaseID = "unit.SkeletonLight" },
			{ BaseID = "unit.SkeletonMedium", StartingResourceMin = 125 },
			{ BaseID = "unit.SkeletonHeavy", StartingResourceMin = 175 }
		]
	},
	{
			ID = "UnitBlock.UndeadBackline",
		UnitDefs = [
			{ BaseID = "unit.SkeletonMediumPolearm", StartingResourceMin = 125 },
			{ BaseID = "unit.SkeletonHeavyPolearm", StartingResourceMin = 175 }
		]
	},
	{
			ID = "UnitBlock.UndeadBoss",
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
