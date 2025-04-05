local unitBlocks = [
	{
		ID = "UnitBlock.RF.BarbarianFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianThrall" }, { BaseID = "Unit.RF.BarbarianMarauder" }, { BaseID = "Unit.RF.BarbarianChampion" }]
		}
	},
	{
		ID = "UnitBlock.RF.BarbarianSupport",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianDrummer" }]
		}
	},
	{
		ID = "UnitBlock.RF.BarbarianDog",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Warhound" }]
		}
	},
	{
		ID = "UnitBlock.RF.BarbarianBeastmaster",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianBeastmasterU" }, { BaseID = "Unit.RF.BarbarianBeastmasterF" }, { BaseID = "Unit.RF.BarbarianBeastmasterUU" }, { BaseID = "Unit.RF.BarbarianBeastmasterFF" }]
		}
	},
	{
		ID = "UnitBlock.RF.BarbarianHunterFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianThrall" }, { BaseID = "Unit.RF.BarbarianMarauder" }]
		}
	},

	{
		ID = "UnitBlock.RF.BarbarianUnhold",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianUnhold" }]
		}
	},
	{
		ID = "UnitBlock.RF.BarbarianUnholdFrost",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BarbarianUnholdFrost" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
