local unitBlocks = [
	{
		ID = "UnitBlock.MercenaryFrontline",
		UnitDefs = [{ BaseID = "Unit.MercenaryLOW" }, { BaseID = "Unit.Mercenary" }]
	},
	{
		ID = "UnitBlock.MercenaryRanged",
		UnitDefs = [{ BaseID = "Unit.MercenaryRanged" }]
	},
	{
		ID = "UnitBlock.MercenaryElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.MasterArcher" }],
			[1, { BaseID = "Unit.HedgeKnight" }],
			[1, { BaseID = "Unit.Swordmaster" }]
		]),
		StartingResourceMin = 286	// In Vanilla MasterArcher appear in a group of 286 cost
	},
	{
		ID = "UnitBlock.BountyHunter",
		UnitDefs = [{ BaseID = "Unit.BountyHunter" }]
	},
	{
		ID = "UnitBlock.BountyHunterRanged",
		UnitDefs = [{ BaseID = "Unit.BountyHunterRanged" }]
	},
	{
		ID = "UnitBlock.Wardog",
		UnitDefs = [{ BaseID = "Unit.Wardog" }]
	},
	{
		ID = "UnitBlock.Slave",
		UnitDefs = [{ BaseID = "Unit.Slave" }]
	},

// Civilians
	{
		ID = "UnitBlock.CultistAmbush",
		UnitDefs = [{ BaseID = "Unit.CultistAmbush" }]
	},
	{
		ID = "UnitBlock.Peasant",
		UnitDefs = [{ BaseID = "Unit.Peasant" }]
	},
	{
		ID = "UnitBlock.SouthernPeasant",
		UnitDefs = [{ BaseID = "Unit.SouthernPeasant" }]
	},
	{
		ID = "UnitBlock.PeasantArmed",
		UnitDefs = [{ BaseID = "Unit.PeasantArmed" }]
	},

// Caravans
	{
		ID = "UnitBlock.CaravanDonkey",
		UnitDefs = [{ BaseID = "Unit.CaravanDonkey" }]
	},
	{
		ID = "UnitBlock.CaravanHand",
		UnitDefs = [{ BaseID = "Unit.CaravanHand" }]
	},
	{
		ID = "UnitBlock.CaravanGuard",
		UnitDefs = [{ BaseID = "Unit.CaravanGuard" }, { BaseID = "Unit.Mercenary" }]		// In Vanilla they also allow ranged mercenaries here
	},

// Militia
	{
		ID = "UnitBlock.MilitiaFrontline",
		UnitDefs = [{ BaseID = "Unit.Militia" }, { BaseID = "Unit.MilitiaVeteran" }]
	},
	{
		ID = "UnitBlock.MilitiaRanged",
		UnitDefs = [{ BaseID = "Unit.MilitiaRanged" }]
	},
	{
		ID = "UnitBlock.MilitiaCaptain",
		UnitDefs = [{ BaseID = "Unit.MilitiaCaptain" }],
		StartingResourceMin = 144	// In Vanilla they appear in a group of 144 cost
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
