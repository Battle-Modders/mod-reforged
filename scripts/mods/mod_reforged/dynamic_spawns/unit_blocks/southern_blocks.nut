local unitBlocks = [
	{
			ID = "UnitBlock.SouthernFrontline",
		//UnitDefs = [{ BaseID = "Conscript" }, { BaseID = "Conscript++" }]
		UnitDefs = [{ BaseID = "Unit.Conscript" }]
	},
	{
			ID = "UnitBlock.SouthernBackline",
		//UnitDefs = [{ BaseID = "Conscript_Polearm" }, { BaseID = "Conscript_Polearm++" }]
		UnitDefs = [{ BaseID = "Unit.Conscript_Polearm" }]
	},
	{
			ID = "UnitBlock.Assassin",
		// UnitDefs = [{ BaseID = "Assassin" }, { BaseID = "Assassin++" }]
		UnitDefs = [{ BaseID = "Unit.Assassin" }]
	},
	{
			ID = "UnitBlock.Officer",
		//UnitDefs = [{ BaseID = "Officer" }, { BaseID = "Officer++" }]
		UnitDefs = [{ BaseID = "Unit.Officer" }],
		StartingResourceMin = 250	// In Vanilla they appear in a group of 250 cost
	},
	{
			ID = "UnitBlock.SouthernRanged",
		//UnitDefs = [{ BaseID = "Gunner" }, { BaseID = "Gunner++" }]
		UnitDefs = [{ BaseID = "Unit.Gunner" }]
	},
	{
			ID = "UnitBlock.Siege",
		UnitDefs = [{ BaseID = "Unit.Mortar" }],
		StartingResourceMin = 340	// In Vanilla they appear in a group of 340 cost
	},
	{
			ID = "UnitBlock.Engineer",
		UnitDefs = [{ BaseID = "Unit.Engineer" }]
	},
	{
			ID = "UnitBlock.Slave",
		UnitDefs = [{ BaseID = "Unit.Slave" }]
	},

// Caravan
	{
	ID = "UnitBlock.SouthernCaravanDonkeys",
		UnitDefs = [{ BaseID = "Unit.SouthernCaravanDonkey" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
