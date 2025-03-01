local unitBlocks = [
	{
		ID = "UnitBlock.RF.NobleFrontline",
		UnitDefs = [
			"Unit.RF.Footman",
			"Unit.RF.RF_FootmanHeavy"
		]
	},
	{
		ID = "UnitBlock.RF.NobleBackline",
		UnitDefs = [
			"Unit.RF.Billman",
			"Unit.RF.RF_BillmanHeavy"
		]
	},
	{
		ID = "UnitBlock.RF.NobleRanged",
		UnitDefs = [
			"Unit.RF.Arbalester",
			"Unit.RF.RF_ArbalesterHeavy"
		]
	},
	{
		ID = "UnitBlock.RF.NobleElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1.0, "Unit.RF.RF_ManAtArms"],
			[0.5, "Unit.RF.Greatsword"],
			[0.5, "Unit.RF.RF_Fencer"]
		])
	},
	{
		ID = "UnitBlock.RF.NobleSupport",
		HardMax = 2,
		UnitDefs = [
			{ BaseID = "Unit.RF.StandardBearer", HardMax = 2 },
			{ BaseID = "Unit.RF.RF_Herald", HardMax = 1 }
		]
	},
	{
		ID = "UnitBlock.RF.NobleOfficer",
		UnitDefs = [
			{ BaseID = "Unit.RF.Sergeant", HardMax = 1 },
			{ BaseID = "Unit.RF.RF_Marshal", HardMax = 1 }
		]
	},
	{
		ID = "UnitBlock.RF.NobleLeader",
		UnitDefs = [
			"Unit.RF.Knight",
			{ BaseID = "Unit.RF.RF_KnightAnointed", HardMax = 1 }
		]
	},
	{
		ID = "UnitBlock.RF.NobleFlank",
		UnitDefs = [{ BaseID = "Unit.RF.ArmoredWardog", HardMax = 3 }]
	},

// Caravan
	{
		ID = "UnitBlock.RF.NobleDonkey",
		UnitDefs = ["Unit.RF.NobleCaravanDonkey"]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
