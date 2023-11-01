local unitBlocks = [
	{
		ID = "UnitBlock.RF.GoblinFrontline",
		UnitDefs =
		[
			{ BaseID = "Unit.RF.GoblinSkirmisherLOW" },
			{ BaseID = "Unit.RF.GoblinSkirmisher" }
		]
	},
	{
		ID = "UnitBlock.RF.GoblinRanged",
		UnitDefs = [
			{ BaseID = "Unit.RF.GoblinAmbusherLOW" },
			{ BaseID = "Unit.RF.GoblinAmbusher" }
		]
	},
	{
		ID = "UnitBlock.RF.GoblinFlank",
		UnitDefs = [{ BaseID = "Unit.RF.GoblinWolfrider" }]
	},
	{
		ID = "UnitBlock.RF.GoblinBoss",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.GoblinOverseer" }],
			[1, { BaseID = "Unit.RF.GoblinShaman" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
