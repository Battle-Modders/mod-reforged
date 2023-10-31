local unitBlocks = [
	{
			ID = "UnitBlock.ScourgeBoss",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.UndeadSkeletonPriestH" }],
			[1, { BaseID = "Unit.UndeadSkeletonPriestHH" }],
			[1, { BaseID = "Unit.UndeadNecromancerYK" }],
			[1, { BaseID = "Unit.UndeadNecromancerKK" }]
		])
	},
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
