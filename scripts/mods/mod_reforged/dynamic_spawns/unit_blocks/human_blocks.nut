local unitBlocks = [
	{
		ID = "UnitBlock.MercenaryFrontline",
		UnitDefs = [{ BaseID = "Unit.HumanMercenaryLOW" }, { BaseID = "Unit.HumanMercenary" }]
	},
	{
		ID = "UnitBlock.MercenaryRanged",
		UnitDefs = [{ BaseID = "Unit.HumanMercenaryRanged" }]
	},
	{
		ID = "UnitBlock.MercenaryElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.HumanMasterArcher" }],
			[1, { BaseID = "Unit.HumanHedgeKnight" }],
			[1, { BaseID = "Unit.HumanSwordmaster" }]
		]),
		StartingResourceMin = 286	// In Vanilla MasterArcher appear in a group of 286 cost
	},
	{
		ID = "UnitBlock.HumanBountyHunter",
		UnitDefs = [{ BaseID = "Unit.HumanBountyHunter" }]
	},
	{
		ID = "UnitBlock.HumanBountyHunterRanged",
		UnitDefs = [{ BaseID = "Unit.HumanBountyHunterRanged" }]
	},
	{
		ID = "UnitBlock.HumanWardogs",
		UnitDefs = [{ BaseID = "Unit.HumanWardog" }]
	},
	{
		ID = "UnitBlock.HumanSlaves",
		UnitDefs = [{ BaseID = "Unit.HumanSlave" }]
	},

// Civilians
	{
		ID = "UnitBlock.HumanCultistAmbush",
		UnitDefs = [{ BaseID = "Unit.HumanCultistAmbush" }]
	},
	{
		ID = "UnitBlock.HumanPeasants",
		UnitDefs = [{ BaseID = "Unit.HumanPeasant" }]
	},
	{
		ID = "UnitBlock.HumanSouthernPeasants",
		UnitDefs = [{ BaseID = "Unit.HumanSouthernPeasant" }]
	},
	{
		ID = "UnitBlock.HumanPeasantsArmed",
		UnitDefs = [{ BaseID = "Unit.HumanPeasantArmed" }]
	},

// Caravans
	{
		ID = "UnitBlock.HumanCaravanDonkeys",
		UnitDefs = [{ BaseID = "Unit.HumanCaravanDonkey" }]
	},
	{
		ID = "UnitBlock.HumanCaravanHands",
		UnitDefs = [{ BaseID = "Unit.HumanCaravanHand" }]
	},
	{
		ID = "UnitBlock.HumanCaravanGuards",
		UnitDefs = [{ BaseID = "Unit.HumanCaravanGuard" }, { BaseID = "Unit.HumanMercenary" }]		// In Vanilla they also allow ranged mercenaries here
	},

// Militia
	{
		ID = "UnitBlock.HumanMilitiaFrontline",
		UnitDefs = [{ BaseID = "Unit.HumanMilitia" }, { BaseID = "Unit.HumanMilitiaVeteran" }]
	},
	{
		ID = "UnitBlock.HumanMilitiaRanged",
		UnitDefs = [{ BaseID = "Unit.HumanMilitiaRanged" }]
	},
	{
		ID = "UnitBlock.HumanMilitiaCaptain",
		UnitDefs = [{ BaseID = "Unit.HumanMilitiaCaptain" }],
		StartingResourceMin = 144	// In Vanilla they appear in a group of 144 cost
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
