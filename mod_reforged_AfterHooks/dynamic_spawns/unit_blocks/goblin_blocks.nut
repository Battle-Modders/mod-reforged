local unitBlocks = [
	{
		ID = "UnitBlock.RF.GoblinFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.GoblinSkirmisher" }]
		}
	},
	{
		ID = "UnitBlock.RF.GoblinRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.GoblinAmbusher" }]
		}
	},
	{
		ID = "UnitBlock.RF.GoblinFlank",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.GoblinWolfrider" }]
		}
	},
	{
		ID = "UnitBlock.RF.GoblinBoss",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.GoblinOverseer" }],
				[1, { BaseID = "Unit.RF.GoblinShaman" }]
			])
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
