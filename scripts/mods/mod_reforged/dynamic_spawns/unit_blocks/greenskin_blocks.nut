local unitBlocks = [
	{
		ID = "UnitBlock.GreenskinGoblinsFoot",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.GoblinSkirmisher" }],
			[1, { BaseID = "Unit.GoblinAmbusher" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
