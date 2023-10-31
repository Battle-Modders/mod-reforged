local unitBlocks = [
	{
		ID = "UnitBlock.GoblinFrontline",
		UnitDefs =
		[
			{ BaseID = "Unit.GoblinSkirmisherLOW" },
			{ BaseID = "Unit.GoblinSkirmisher" }
		]
	},
	{
		ID = "UnitBlock.GoblinRanged",
		UnitDefs = [
			{ BaseID = "Unit.GoblinAmbusherLOW" },
			{ BaseID = "Unit.GoblinAmbusher" }
		]
	},
	{
		ID = "UnitBlock.GoblinFlank",
		UnitDefs = [{ BaseID = "Unit.GoblinWolfrider" }]
	},
	{
		ID = "UnitBlock.GoblinBoss",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.GoblinOverseer" }],
			[1, { BaseID = "Unit.GoblinShaman" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
