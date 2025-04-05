local unitBlocks = [
	{
		ID = "UnitBlock.RF.NomadFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.NomadCutthroat" }, { BaseID = "Unit.RF.NomadOutlaw" }]
		}
	},
	{
		ID = "UnitBlock.RF.NomadRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.NomadSlinger" }, { BaseID = "Unit.RF.NomadArcher" }]
		}
	},
	{
		ID = "UnitBlock.RF.NomadLeader",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.NomadLeader" }]
		}
	},
	{
		ID = "UnitBlock.RF.NomadElite",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.Executioner" }],
				[1, { BaseID = "Unit.RF.DesertStalker" }],
				[1, { BaseID = "Unit.RF.DesertDevil" }]
			])
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
