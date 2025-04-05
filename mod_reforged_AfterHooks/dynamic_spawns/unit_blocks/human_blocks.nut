local unitBlocks = [
	{
		ID = "UnitBlock.RF.MercenaryFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Mercenary" }]
		}
	},
	{
		ID = "UnitBlock.RF.MercenaryRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.MercenaryRanged" }]
		}
	},
	{
		ID = "UnitBlock.RF.MercenaryElite",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.MasterArcher" }],
				[1, { BaseID = "Unit.RF.HedgeKnight" }],
				[1, { BaseID = "Unit.RF.Swordmaster" }]
			])
		}
	},
	{
		ID = "UnitBlock.RF.BountyHunter",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BountyHunter" }]
		}
	},
	{
		ID = "UnitBlock.RF.BountyHunterRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BountyHunterRanged" }]
		}
	},
	{
		ID = "UnitBlock.RF.Wardog",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Wardog" }]
		}
	},
	{
		ID = "UnitBlock.RF.Slave",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Slave" }]
		}
	},

// Civilians
	{
		ID = "UnitBlock.RF.CultistAmbush",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.CultistAmbush" }]
		}
	},
	{
		ID = "UnitBlock.RF.Peasant",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Peasant" }]
		}
	},
	{
		ID = "UnitBlock.RF.SouthernPeasant",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.SouthernPeasant" }]
		}
	},
	{
		ID = "UnitBlock.RF.PeasantArmed",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.PeasantArmed" }]
		}
	},

// Caravans
	{
		ID = "UnitBlock.RF.CaravanDonkey",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.CaravanDonkey" }]
		}
	},
	{
		ID = "UnitBlock.RF.CaravanHand",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.CaravanHand" }]
		}
	},
	{
		ID = "UnitBlock.RF.CaravanGuard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.CaravanGuard" }, { BaseID = "Unit.RF.Mercenary" }]
		}		// In Vanilla they also allow ranged mercenaries here
	},

// Militia
	{
		ID = "UnitBlock.RF.MilitiaFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Militia" }, { BaseID = "Unit.RF.MilitiaVeteran" }]
		}
	},
	{
		ID = "UnitBlock.RF.MilitiaRanged",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.MilitiaRanged" }]
		}
	},
	{
		ID = "UnitBlock.RF.MilitiaCaptain",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.MilitiaCaptain" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
