local unitBlocks = [
	{
		ID = "UnitBlock.RF.MercenaryFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.Mercenary" }]
	},
	{
		ID = "UnitBlock.RF.MercenaryRanged",
		UnitDefs = [{ BaseID = "Unit.RF.MercenaryRanged" }]
	},
	{
		ID = "UnitBlock.RF.MercenaryElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.MasterArcher" }],
			[1, { BaseID = "Unit.RF.HedgeKnight" }],
			[1, { BaseID = "Unit.RF.Swordmaster" }]
		])
	},
	{
		ID = "UnitBlock.RF.BountyHunter",
		UnitDefs = [{ BaseID = "Unit.RF.BountyHunter" }]
	},
	{
		ID = "UnitBlock.RF.BountyHunterRanged",
		UnitDefs = [{ BaseID = "Unit.RF.BountyHunterRanged" }]
	},
	{
		ID = "UnitBlock.RF.Wardog",
		UnitDefs = [{ BaseID = "Unit.RF.Wardog" }]
	},
	{
		ID = "UnitBlock.RF.Slave",
		UnitDefs = [{ BaseID = "Unit.RF.Slave" }]
	},

// Civilians
	{
		ID = "UnitBlock.RF.CultistAmbush",
		UnitDefs = [{ BaseID = "Unit.RF.CultistAmbush" }]
	},
	{
		ID = "UnitBlock.RF.Peasant",
		UnitDefs = [{ BaseID = "Unit.RF.Peasant" }]
	},
	{
		ID = "UnitBlock.RF.SouthernPeasant",
		UnitDefs = [{ BaseID = "Unit.RF.SouthernPeasant" }]
	},
	{
		ID = "UnitBlock.RF.PeasantArmed",
		UnitDefs = [{ BaseID = "Unit.RF.PeasantArmed" }]
	},

// Caravans
	{
		ID = "UnitBlock.RF.CaravanDonkey",
		UnitDefs = [{ BaseID = "Unit.RF.CaravanDonkey" }]
	},
	{
		ID = "UnitBlock.RF.CaravanHand",
		UnitDefs = [{ BaseID = "Unit.RF.CaravanHand" }]
	},
	{
		ID = "UnitBlock.RF.CaravanGuard",
		UnitDefs = [{ BaseID = "Unit.RF.CaravanGuard" }, { BaseID = "Unit.RF.Mercenary" }]		// In Vanilla they also allow ranged mercenaries here
	},

// Militia
	{
		ID = "UnitBlock.RF.MilitiaFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.Militia" }, { BaseID = "Unit.RF.MilitiaVeteran" }]
	},
	{
		ID = "UnitBlock.RF.MilitiaRanged",
		UnitDefs = [{ BaseID = "Unit.RF.MilitiaRanged" }]
	},
	{
		ID = "UnitBlock.RF.MilitiaCaptain",
		UnitDefs = [{ BaseID = "Unit.RF.MilitiaCaptain" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
