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
		UnitDefs = [{ BaseID = "Unit.NomadLeader" }],
		StartingResourceMin = 170	// In Vanilla they appear in a group of 170 cost
	},
	{
		ID = "UnitBlock.NomadElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.NomadExecutioner" }],
			[1, { BaseID = "Unit.NomadDesertStalker" }],
			[1, { BaseID = "Unit.NomadDesertDevil" }]
		]),
		StartingResourceMin = 350	// In Vanilla Executioner appear in a group of 350 cost
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
