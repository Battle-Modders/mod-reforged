local unitBlocks = [
	{
		ID = "UnitBlock.BarbarianFrontline",
		UnitDefs = [{ BaseID = "Unit.BarbarianThrall" }, { BaseID = "Unit.BarbarianMarauder", StartingResourceMin = 125 }, { BaseID = "Unit.BarbarianChosen", StartingResourceMin = 200 }]
	},
	{
		ID = "UnitBlock.BarbarianSupport",
		UnitDefs = [{ BaseID = "Unit.BarbarianDrummer" }],
		StartingResourceMin = 200	// In Vanilla they start appearing in a group of 210 cost alongside 15 thralls

	},
	{
		ID = "UnitBlock.BarbarianDogs",
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
		ID = "UnitBlock.BarbarianUnholds",
		UnitDefs = [{ BaseID = "Unit.BarbarianUnhold" }]
	},
	{
		ID = "UnitBlock.BarbarianUnholdsFrost",
		UnitDefs = [{ BaseID = "Unit.BarbarianUnholdFrost" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
