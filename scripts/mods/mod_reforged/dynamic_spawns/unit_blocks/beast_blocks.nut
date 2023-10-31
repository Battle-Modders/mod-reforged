local unitBlocks = [
	// Purebred Beasts
	{
		ID = "UnitBlock.BeastDirewolves",
		UnitDefs = [{ BaseID = "Unit.BeastDirewolf" }, { BaseID = "Unit.BeastDirewolfHIGH" }]
	},
	{
		ID = "UnitBlock.BeastGhoulLowOnly",
		UnitDefs = [{ BaseID = "Unit.BeastGhoulLOW" }]
	},
	{
		ID = "UnitBlock.BeastGhouls",
		UnitDefs = [{ BaseID = "Unit.BeastGhoulLOW" }, { BaseID = "Unit.BeastGhoul", StartingResourceMin = 125 }, { BaseID = "Unit.BeastGhoulHIGH", StartingResourceMin = 175 }]
	},
	{
		ID = "UnitBlock.BeastLindwurms",
		UnitDefs = [{ BaseID = "Unit.BeastLindwurm" }]
	},
	{
		ID = "UnitBlock.BeastUnholds",
		UnitDefs = [{ BaseID = "Unit.BeastUnhold" }]
	},
	{
		ID = "UnitBlock.BeastUnholdsFrost",
		UnitDefs = [{ BaseID = "Unit.BeastUnholdFrost" }]
	},
	{
		ID = "UnitBlock.BeastUnholdsBog",
		UnitDefs = [{ BaseID = "Unit.BeastUnholdBog" }]
	},
	{
		ID = "UnitBlock.BeastSpiders",
		UnitDefs = [{ BaseID = "Unit.BeastSpider" }]
	},
	{
		ID = "UnitBlock.BeastAlps",
		UnitDefs = [{ BaseID = "Unit.BeastAlp" }]
	},
	{
		ID = "UnitBlock.BeastSchrats",
		UnitDefs = [{ BaseID = "Unit.BeastSchrat" }]
	},
	// Vanilla Kraken skipped at this point
	{
		ID = "UnitBlock.BeastHyenas",
		UnitDefs = [{ BaseID = "Unit.BeastHyena" }, { BaseID = "Unit.BeastHyenaHIGH" }]
	},
	{
		ID = "UnitBlock.BeastSerpents",
		UnitDefs = [{ BaseID = "Unit.BeastSerpent" }]
	},
	{
		ID = "UnitBlock.BeastSandGolems",
		UnitDefs = [{ BaseID = "Unit.BeastSandGolem" }, { BaseID = "Unit.BeastSandGolemMEDIUM" }, { BaseID = "Unit.BeastSandGolemHIGH" }]
	},

// Mixed Beasts
	{
		ID = "UnitBlock.BeastHexenNoBodyguards",
		UnitDefs = [{ BaseID = "Unit.BeastHexe" }]
	},
	{
		ID = "UnitBlock.BeastHexenWithBodyguards",
		UnitDefs = [{ BaseID = "Unit.BeastHexe" }, { BaseID = "Unit.BeastHexeOneSpider" }, { BaseID = "Unit.BeastHexeTwoSpider" }, { BaseID = "Unit.BeastHexeOneDirewolf" }, { BaseID = "Unit.BeastHexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.BeastHexenNoSpiders",
		UnitDefs = [{ BaseID = "Unit.BeastHexe" }, { BaseID = "Unit.BeastHexeOneDirewolf" }, { BaseID = "Unit.BeastHexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.BeastHexenBandits",    // Spawn in HexenFights
		UnitDefs = [{ BaseID = "Unit.BanditRaider" }]
	},
	{
		ID = "UnitBlock.BeastHexenBanditsRanged",    // Spawn in HexenFights. In Vanilla they only ever spawn a single marksman alongside several raiders. Never more
		UnitDefs = [{ BaseID = "Unit.BanditMarksman" }]
	},

// Bodyguards
	{
		ID = "UnitBlock.BeastSpiderBodyguards",
		UnitDefs = [{ BaseID = "Unit.BeastSpiderBodyguard" }]
	},
	{
		ID = "UnitBlock.BeastDirewolfBodyguards",
		UnitDefs = [{ BaseID = "Unit.BeastDirewolfBodyguard" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
