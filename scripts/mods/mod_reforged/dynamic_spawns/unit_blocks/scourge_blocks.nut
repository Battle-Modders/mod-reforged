local unitBlocks = [
	{
			ID = "UnitBlock.ScourgeBoss",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.SkeletonPriestH" }],
			[1, { BaseID = "Unit.SkeletonPriestHH" }],
			[1, { BaseID = "Unit.NecromancerYK" }],
			[1, { BaseID = "Unit.NecromancerKK" }]
		])
	},
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
