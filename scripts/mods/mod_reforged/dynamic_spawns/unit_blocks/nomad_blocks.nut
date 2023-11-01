local unitBlocks = [
	{
		ID = "UnitBlock.RF.NomadFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.NomadCutthroat" }, { BaseID = "Unit.RF.NomadOutlaw" }]
	},
	{
		ID = "UnitBlock.RF.NomadRanged",
		UnitDefs = [{ BaseID = "Unit.RF.NomadSlinger" }, { BaseID = "Unit.RF.NomadArcher" }]
	},
	{
		ID = "UnitBlock.RF.NomadLeader",
		UnitDefs = [{ BaseID = "Unit.RF.NomadLeader" }]
	},
	{
		ID = "UnitBlock.RF.NomadElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.NomadExecutioner" }],
			[1, { BaseID = "Unit.RF.NomadDesertStalker" }],
			[1, { BaseID = "Unit.RF.NomadDesertDevil" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
