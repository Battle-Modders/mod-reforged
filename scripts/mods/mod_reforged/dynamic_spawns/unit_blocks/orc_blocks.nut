local unitBlocks = [
	{
		ID = "UnitBlock.RF.OrcYoung",
		UnitDefs = [{ BaseID = "Unit.RF.OrcYoung" }]
	},
	{
		ID = "UnitBlock.RF.OrcWarrior",
		UnitDefs = [{ BaseID = "Unit.RF.OrcWarrior" }]
	},
	{
		ID = "UnitBlock.RF.OrcBerserker",
		UnitDefs = [{ BaseID = "Unit.RF.OrcBerserker" }]
	},
	{
		ID = "UnitBlock.RF.OrcBoss",
		UnitDefs = [{ BaseID = "Unit.RF.OrcWarlord" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
