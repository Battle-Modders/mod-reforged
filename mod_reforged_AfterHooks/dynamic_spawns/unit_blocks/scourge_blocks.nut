local unitBlocks = [
	{
		ID = "UnitBlock.RF.ScourgeSupport",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.SkeletonPriestPH" }],
				[1, { BaseID = "Unit.RF.SkeletonPriestHH" }],
				[1, { BaseID = "Unit.RF.NecromancerYK" }],
				[1, { BaseID = "Unit.RF.NecromancerKK" }]
			])
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
