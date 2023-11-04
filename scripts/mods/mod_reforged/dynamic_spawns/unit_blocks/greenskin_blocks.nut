local unitBlocks = [
	{
		ID = "UnitBlock.RF.GoblinRegular",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.GoblinSkirmisher" }],
			[1, { BaseID = "Unit.RF.GoblinAmbusher" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
