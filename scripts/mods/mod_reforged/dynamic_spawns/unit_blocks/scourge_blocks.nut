local unitBlocks = [
	{
		ID = "UnitBlock.RF.ScourgeSupport",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.SkeletonPriestPH" }],
			[1, { BaseID = "Unit.RF.SkeletonPriestHH" }],
			[1, { BaseID = "Undead.RF.NecromancerYK" }],
			[1, { BaseID = "Undead.RF.NecromancerKK" }]
		])
	},
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
