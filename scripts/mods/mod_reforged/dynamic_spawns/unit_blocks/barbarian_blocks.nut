local unitBlocks = [
	{
		ID = "UnitBlock.BarbarianFrontline",
		UnitDefs = [{ BaseID = "Unit.BarbarianThrall" }, { BaseID = "Unit.BarbarianMarauder", StartingResourceMin = 125 }, { BaseID = "Unit.BarbarianChosen", StartingResourceMin = 200 }]
	},
	{
		ID = "UnitBlock.BarbarianSupport",
		UnitDefs = [{ BaseID = "Unit.BarbarianDrummer" }]

	},
	{
		ID = "UnitBlock.BarbarianDog",
		UnitDefs = [{ BaseID = "Unit.BarbarianWarhound" }]
	},
	{
		ID = "UnitBlock.BarbarianBeastmaster",
		UnitDefs = [{ BaseID = "Unit.BarbarianBeastmasterU" }, { BaseID = "Unit.BarbarianBeastmasterF" }, { BaseID = "Unit.BarbarianBeastmasterUU" }, { BaseID = "Unit.BarbarianBeastmasterFF" }],
		StartingResourceMin = 200	// In Vanilla they appear in a group of 195 cost
	},
	{
		ID = "UnitBlock.BarbarianHunterFrontline",
		UnitDefs = [{ BaseID = "Unit.BarbarianThrall" }]
	},

	{
		ID = "UnitBlock.BarbarianUnhold",
		UnitDefs = [{ BaseID = "Unit.BarbarianUnhold" }]
	},
	{
		ID = "UnitBlock.BarbarianUnholdFrost",
		UnitDefs = [{ BaseID = "Unit.BarbarianUnholdFrost" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
