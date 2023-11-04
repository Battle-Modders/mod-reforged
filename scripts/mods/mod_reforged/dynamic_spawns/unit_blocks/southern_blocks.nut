local unitBlocks = [
	{
		ID = "UnitBlock.RF.SouthernFrontline",
		//UnitDefs = [{ BaseID = "Conscript" }, { BaseID = "Conscript++" }]
		UnitDefs = [{ BaseID = "Unit.RF.Conscript" }]
	},
	{
		ID = "UnitBlock.RF.SouthernBackline",
		//UnitDefs = [{ BaseID = "Conscript_Polearm" }, { BaseID = "Conscript_Polearm++" }]
		UnitDefs = [{ BaseID = "Unit.RF.Conscript_Polearm" }]
	},
	{
		ID = "UnitBlock.RF.Assassin",
		// UnitDefs = [{ BaseID = "Assassin" }, { BaseID = "Assassin++" }]
		UnitDefs = [{ BaseID = "Unit.RF.Assassin" }]
	},
	{
		ID = "UnitBlock.RF.Officer",
		//UnitDefs = [{ BaseID = "Officer" }, { BaseID = "Officer++" }]
		UnitDefs = [{ BaseID = "Unit.RF.Officer" }]
	},
	{
		ID = "UnitBlock.RF.SouthernRanged",
		//UnitDefs = [{ BaseID = "Gunner" }, { BaseID = "Gunner++" }]
		UnitDefs = [{ BaseID = "Unit.RF.Gunner" }]
	},
	{
		ID = "UnitBlock.RF.Siege",
		UnitDefs = [{ BaseID = "Unit.RF.Mortar" }]
	},
	{
		ID = "UnitBlock.RF.Engineer",
		UnitDefs = [{ BaseID = "Unit.RF.Engineer" }]
	},
	{
		ID = "UnitBlock.RF.Slave",
		UnitDefs = [{ BaseID = "Unit.RF.Slave" }]
	},

// Caravan
	{
		ID = "UnitBlock.RF.SouthernCaravanDonkey",
		UnitDefs = [{ BaseID = "Unit.RF.SouthernDonkey" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
