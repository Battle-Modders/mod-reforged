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
			Units = { BaseID = "Unit.RF.GoblinOverseer" }
		}
	},
	{
		ID = "UnitBlock.RF.GoblinSupport",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.GoblinShaman" }]
		}
	}
];

foreach (blockDef in unitBlocks)
{
	::Reforged.Spawns.UnitBlocks[blockDef.ID] <- blockDef;
}
