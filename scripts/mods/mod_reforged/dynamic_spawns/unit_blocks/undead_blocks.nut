local unitBlocks = [
	{
			ID = "UnitBlock.UndeadFrontline",
		UnitDefs = [
			{ BaseID = "Unit.UndeadSkeletonLight" },
			{ BaseID = "Unit.UndeadSkeletonMedium", StartingResourceMin = 125 },
			{ BaseID = "Unit.UndeadSkeletonHeavy", StartingResourceMin = 175 }
		]
	},
	{
			ID = "UnitBlock.UndeadBackline",
		UnitDefs = [
			{ BaseID = "Unit.UndeadSkeletonMediumPolearm", StartingResourceMin = 125 },
			{ BaseID = "Unit.UndeadSkeletonHeavyPolearm", StartingResourceMin = 175 }
		]
	},
	{
			ID = "UnitBlock.UndeadBoss",
		UnitDefs = [
			{ BaseID = "Unit.UndeadSkeletonPriestH" },
			{ BaseID = "Unit.UndeadSkeletonPriestHH" }
		]
	},
	{
			ID = "UnitBlock.UndeadSkeletonHeavyBodyguard",
		UnitDefs = [
			{ BaseID = "Unit.UndeadSkeletonHeavyBodyguard" }
		]
	},
	{
			ID = "UnitBlock.UndeadVampire",
		UnitDefs = [
			{ BaseID = "Unit.UndeadVampireLOW" },
			{ BaseID = "Unit.UndeadVampire" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
