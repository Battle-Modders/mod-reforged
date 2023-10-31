local unitBlocks = [
	{
		ID = "UnitBlock.OrcYoung",
		UnitDefs = [{ BaseID = "Unit.OrcYoungLOW" }, { BaseID = "Unit.OrcYoung" }]
	},
	{
		ID = "UnitBlock.OrcWarrior",
		UnitDefs = [{ BaseID = "Unit.OrcWarriorLOW" }, { BaseID = "Unit.OrcWarrior" }]
	},
	{
		ID = "UnitBlock.OrcBerserker",
		UnitDefs = [{ BaseID = "Unit.OrcBerserker" }]
	},
	{
		ID = "UnitBlock.OrcBoss",
		UnitDefs = [{ BaseID = "Unit.OrcWarlord" }],
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
