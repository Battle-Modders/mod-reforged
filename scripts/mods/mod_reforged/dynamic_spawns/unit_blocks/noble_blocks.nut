local unitBlocks = [
	{
		ID = "UnitBlock.RF.NobleFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.NobleFootman" }]
	},
	{
		ID = "UnitBlock.RF.NobleBackline",
		UnitDefs = [{ BaseID = "Unit.RF.NobleBillman" }]
	},
	{
		ID = "UnitBlock.RF.NobleRanged",
		UnitDefs = [{ BaseID = "Unit.RF.NobleArbalester" }]
	},
	{
		ID = "UnitBlock.RF.NobleFlank",
		UnitDefs = [{ BaseID = "Unit.RF.NobleArmoredWardog" }]
	},
	{
		ID = "UnitBlock.RF.NobleSupport",
		UnitDefs = [{ BaseID = "Unit.RF.NobleStandardBearer" }]
	},
	{
		ID = "UnitBlock.RF.NobleOfficer",
		UnitDefs = [{ BaseID = "Unit.RF.NobleSergeant" }]
	},
	{
		ID = "UnitBlock.RF.NobleElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.NobleZweihander" }],
			[1, { BaseID = "Unit.RF.NobleKnight" }]
		])
	},

// Caravan
	{
	ID = "UnitBlock.RF.NobleDonkeys",
		UnitDefs = [{ BaseID = "Unit.RF.NobleCaravanDonkey" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
