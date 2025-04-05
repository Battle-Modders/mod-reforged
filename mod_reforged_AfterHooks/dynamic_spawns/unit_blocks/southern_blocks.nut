local unitBlocks = [
	{
		ID = "UnitBlock.RF.SouthernFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Conscript" }]
		}
	},
	{
		ID = "UnitBlock.RF.SouthernBackline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Conscript_Polearm" }]
		}
	},
	{
		ID = "UnitBlock.RF.Assassin",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Assassin" }]
		}
	},
	{
		ID = "UnitBlock.RF.Officer",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Officer" }]
		}
	},
	{
		ID = "UnitBlock.RF.SouthernRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Gunner" }]
		}
	},
	{
		ID = "UnitBlock.RF.Siege",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Mortar" }]
		}
	},
	{
		ID = "UnitBlock.RF.Engineer",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Engineer" }]
		}
	},
	{
		ID = "UnitBlock.RF.Slave",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Slave" }]
		}
	},

// Caravan
	{
		ID = "UnitBlock.RF.SouthernCaravanDonkey",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.SouthernDonkey" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
