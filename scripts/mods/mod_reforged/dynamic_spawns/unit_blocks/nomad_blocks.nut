local unitBlocks = [
	{
		ID = "UnitBlock.NomadFrontline",
		UnitDefs = [{ BaseID = "Unit.NomadCutthroat" }, { BaseID = "Unit.NomadOutlaw" }]
	},
	{
		ID = "UnitBlock.NomadRanged",
		UnitDefs = [{ BaseID = "Unit.NomadSlinger" }, { BaseID = "Unit.NomadArcher" }]
	},
	{
		ID = "UnitBlock.NomadLeader",
		UnitDefs = [{ BaseID = "Unit.NomadLeader" }]
	},
	{
		ID = "UnitBlock.NomadElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.NomadExecutioner" }],
			[1, { BaseID = "Unit.NomadDesertStalker" }],
			[1, { BaseID = "Unit.NomadDesertDevil" }]
		])
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
