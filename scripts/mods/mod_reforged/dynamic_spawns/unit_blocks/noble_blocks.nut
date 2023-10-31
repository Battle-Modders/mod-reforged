local unitBlocks = [
	{
		ID = "UnitBlock.NobleFrontline",
		UnitDefs = [{ BaseID = "Unit.NobleFootman" }]
	},
	{
		ID = "UnitBlock.NobleBackline",
		UnitDefs = [{ BaseID = "Unit.NobleBillman" }]
	},
	{
		ID = "UnitBlock.NobleRanged",
		UnitDefs = [{ BaseID = "Unit.NobleArbalester" }]
	},
	{
		ID = "UnitBlock.NobleFlank",
		UnitDefs = [{ BaseID = "Unit.NobleArmoredWardog" }]
	},
	{
		ID = "UnitBlock.NobleSupport",
		UnitDefs = [{ BaseID = "Unit.NobleStandardBearer" }],
		StartingResourceMin = 200	// In Vanilla they appear in a group of 240 cost
	},
	{
		ID = "UnitBlock.NobleOfficer",
		UnitDefs = [{ BaseID = "Unit.NobleSergeant" }],
		StartingResourceMin = 200	// In Vanilla they appear in a group of 235 cost in noble caravans
	},
	{
		ID = "UnitBlock.NobleElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.NobleZweihander" }],
			[1, { BaseID = "Unit.NobleKnight" }]
		]),
		StartingResourceMin = 325	// In Vanilla they appear in a group of 235 cost in noble caravans
	},

// Caravan
	{
	ID = "UnitBlock.NobleDonkeys",
		UnitDefs = [{ BaseID = "Unit.NobleCaravanDonkey" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
