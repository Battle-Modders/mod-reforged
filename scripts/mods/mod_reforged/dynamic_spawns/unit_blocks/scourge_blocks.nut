local unitBlocks = [
	{
		ID = "UnitBlock.RF.ScourgeBoss",
		StartingResourceMin = 350,
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.SkeletonPriestH" }],
			[1, { BaseID = "Unit.RF.SkeletonPriestHH" }],
			[1, { BaseID = "Unit.RF.NecromancerYK" }],
			[1, { BaseID = "Unit.RF.NecromancerKK" }]
		])
	},
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
