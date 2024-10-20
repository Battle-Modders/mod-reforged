local unitBlocks = [
	{
		ID = "UnitBlock.RF.BarbarianFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianThrall" }, { BaseID = "Unit.RF.BarbarianMarauder" }, { BaseID = "Unit.RF.BarbarianChampion" }]
	},
	{
		ID = "UnitBlock.RF.BarbarianSupport",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianDrummer" }]

	},
	{
		ID = "UnitBlock.RF.BarbarianDog",
		UnitDefs = [{ BaseID = "Unit.RF.Warhound" }]
	},
	{
		ID = "UnitBlock.RF.BarbarianBeastmaster",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianBeastmasterU" }, { BaseID = "Unit.RF.BarbarianBeastmasterF" }, { BaseID = "Unit.RF.BarbarianBeastmasterUU" }, { BaseID = "Unit.RF.BarbarianBeastmasterFF" }]
	},
	{
		ID = "UnitBlock.RF.BarbarianHunterFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianThrall" }, { BaseID = "Unit.RF.BarbarianMarauder" }]
	},

	{
		ID = "UnitBlock.RF.BarbarianUnhold",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianUnhold" }]
	},
	{
		ID = "UnitBlock.RF.BarbarianUnholdFrost",
		UnitDefs = [{ BaseID = "Unit.RF.BarbarianUnholdFrost" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
