local unitBlocks = [
	{
		ID = "UnitBlock.RF.NobleFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.Footman" }]
	},
	{
		ID = "UnitBlock.RF.NobleBackline",
		UnitDefs = [{ BaseID = "Unit.RF.Billman" }]
	},
	{
		ID = "UnitBlock.RF.NobleRanged",
		UnitDefs = [{ BaseID = "Unit.RF.Arbalester" }]
	},
	{
		ID = "UnitBlock.RF.NobleFlank",
		UnitDefs = [{ BaseID = "Unit.RF.ArmoredWardog" }]
	},
	{
		ID = "UnitBlock.RF.NobleSupport",
		UnitDefs = [{ BaseID = "Unit.RF.StandardBearer" }]
	},
	{
		ID = "UnitBlock.RF.NobleOfficer",
		UnitDefs = [{ BaseID = "Unit.RF.Sergeant" }]
	},
	{
		ID = "UnitBlock.RF.NobleElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.Greatsword" }],
			[1, { BaseID = "Unit.RF.Knight" }]
		])
	},

// Caravan
	{
	ID = "UnitBlock.RF.NobleDonkey",
		UnitDefs = [{ BaseID = "Unit.RF.NobleCaravanDonkey" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
