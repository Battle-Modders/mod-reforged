local unitBlocks = [
	{
		ID = "UnitBlock.RF.OrcYoung",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.OrcYoung" }]
		}
	},
	{
		ID = "UnitBlock.RF.OrcWarrior",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.OrcWarrior" }]
		}
	},
	{
		ID = "UnitBlock.RF.OrcBerserker",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.OrcBerserker" }]
		}
	},
	{
		ID = "UnitBlock.RF.OrcBoss",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.OrcWarlord" }]
		}
	}
];

foreach (blockDef in unitBlocks)
{
	::Reforged.Spawns.UnitBlocks[blockDef.ID] <- blockDef;
}
