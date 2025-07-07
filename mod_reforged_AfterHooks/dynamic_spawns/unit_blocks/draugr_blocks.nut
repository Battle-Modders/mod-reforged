 local unitBlocks = [
	{
		ID = "UnitBlock.RF.DraugrStandard",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrThrall", function onBeforeSpawnStart() { this.RatioMin = ::MSU.Math.randf(0.05, 0.15) } },
				{ BaseID = "Unit.RF.RF_DraugrWarrior", function onBeforeSpawnStart() { this.RatioMin = ::MSU.Math.randf(0.05, 0.2) } },
				{ BaseID = "Unit.RF.RF_DraugrHuskarl", StartingResourceMin = 350 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.DraugrShaman",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrShaman" },
				{ BaseID = "Unit.RF.RF_DraugrShamanWithBodyguards" },
			]
		}
	},
	{
		ID = "UnitBlock.RF.DraugrShamanWithBodyguards",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrShamanWithBodyguards" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.DraugrBodyguard"
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrThrallBodyguard" },
				{ BaseID = "Unit.RF.RF_DraugrWarriorBodyguard" }
			]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
