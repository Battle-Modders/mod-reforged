local unitBlocks = [
	{
			ID = "UnitBlock.SouthernFrontline",
		//UnitDefs = [{ BaseID = "Conscript" }, { BaseID = "Conscript++" }]
		UnitDefs = [{ BaseID = "Unit.SouthernConscript" }]
	},
	{
			ID = "UnitBlock.SouthernBackline",
		//UnitDefs = [{ BaseID = "Conscript_Polearm" }, { BaseID = "Conscript_Polearm++" }]
		UnitDefs = [{ BaseID = "Unit.SouthernConscript_Polearm" }]
	},
	{
			ID = "UnitBlock.SouthernAssassins",
		// UnitDefs = [{ BaseID = "Assassin" }, { BaseID = "Assassin++" }]
		UnitDefs = [{ BaseID = "Unit.SouthernAssassin" }]
	},
	{
			ID = "UnitBlock.SouthernOfficers",
		//UnitDefs = [{ BaseID = "Officer" }, { BaseID = "Officer++" }]
		UnitDefs = [{ BaseID = "Unit.SouthernOfficer" }],
		StartingResourceMin = 250	// In Vanilla they appear in a group of 250 cost
	},
	{
			ID = "UnitBlock.SouthernRanged",
		//UnitDefs = [{ BaseID = "Gunner" }, { BaseID = "Gunner++" }]
		UnitDefs = [{ BaseID = "Unit.SouthernGunner" }]
	},
	{
			ID = "UnitBlock.SouthernSiege",
		UnitDefs = [{ BaseID = "Unit.SouthernMortar" }],
		StartingResourceMin = 340	// In Vanilla they appear in a group of 340 cost
	},
	{
			ID = "UnitBlock.SouthernEngineer",
		UnitDefs = [{ BaseID = "Unit.SouthernEngineer" }]
	},
	{
			ID = "UnitBlock.SouthernSlaves",
		UnitDefs = [{ BaseID = "Unit.SouthernSlave" }]
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
