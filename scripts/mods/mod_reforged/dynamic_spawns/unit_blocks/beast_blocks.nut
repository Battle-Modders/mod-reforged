local unitBlocks = [
	// Purebred Beasts
	{
		ID = "UnitBlock.Direwolf",
		UnitDefs = [{ BaseID = "Unit.Direwolf" }, { BaseID = "Unit.DirewolfHIGH" }]
	},
	{
		ID = "UnitBlock.GhoulLowOnly",
		UnitDefs = [{ BaseID = "Unit.GhoulLOW" }]
	},
	{
		ID = "UnitBlock.Ghoul",
		UnitDefs = [{ BaseID = "Unit.GhoulLOW" }, { BaseID = "Unit.Ghoul", StartingResourceMin = 125 }, { BaseID = "Unit.GhoulHIGH", StartingResourceMin = 175 }]
	},
	{
		ID = "UnitBlock.Lindwurm",
		UnitDefs = [{ BaseID = "Unit.Lindwurm" }]
	},
	{
		ID = "UnitBlock.Unhold",
		UnitDefs = [{ BaseID = "Unit.Unhold" }]
	},
	{
		ID = "UnitBlock.UnholdFrost",
		UnitDefs = [{ BaseID = "Unit.UnholdFrost" }]
	},
	{
		ID = "UnitBlock.UnholdBog",
		UnitDefs = [{ BaseID = "Unit.UnholdBog" }]
	},
	{
		ID = "UnitBlock.Spider",
		UnitDefs = [{ BaseID = "Unit.Spider" }]
	},
	{
		ID = "UnitBlock.Alp",
		UnitDefs = [{ BaseID = "Unit.Alp" }]
	},
	{
		ID = "UnitBlock.Schrat",
		UnitDefs = [{ BaseID = "Unit.Schrat" }]
	},
	// Vanilla Kraken skipped at this point
	{
		ID = "UnitBlock.Hyena",
		UnitDefs = [{ BaseID = "Unit.Hyena" }, { BaseID = "Unit.HyenaHIGH" }]
	},
	{
		ID = "UnitBlock.Serpent",
		UnitDefs = [{ BaseID = "Unit.Serpent" }]
	},
	{
		ID = "UnitBlock.SandGolem",
		UnitDefs = [{ BaseID = "Unit.SandGolem" }, { BaseID = "Unit.SandGolemMEDIUM" }, { BaseID = "Unit.SandGolemHIGH" }]
	},

// Mixed Beasts
	{
		ID = "UnitBlock.HexeNoBodyguard",
		UnitDefs = [{ BaseID = "Unit.Hexe" }]
	},
	{
		ID = "UnitBlock.HexeWithBodyguard",
		StartingResourceMin = 300,
		UnitDefs = [{ BaseID = "Unit.Hexe" }, { BaseID = "Unit.HexeOneSpider" }, { BaseID = "Unit.HexeTwoSpider" }, { BaseID = "Unit.HexeOneDirewolf" }, { BaseID = "Unit.HexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.HexeNoSpider",
		StartingResourceMin = 300,
		UnitDefs = [{ BaseID = "Unit.Hexe" }, { BaseID = "Unit.HexeOneDirewolf" }, { BaseID = "Unit.HexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.HexeBandit",    // Spawn in HexenFights
		StartingResourceMin = 200,
		UnitDefs = [{ BaseID = "Unit.BanditRaider" }]
	},
	{
		ID = "UnitBlock.HexeBanditRanged",    // Spawn in HexenFights. In Vanilla they only ever spawn a single marksman alongside several raiders. Never more
		StartingResourceMin = 200,
		UnitDefs = [{ BaseID = "Unit.BanditMarksman" }]
	},

// Bodyguards
	{
		ID = "UnitBlock.SpiderBodyguard",
		UnitDefs = [{ BaseID = "Unit.SpiderBodyguard" }]
	},
	{
		ID = "UnitBlock.DirewolfBodyguard",
		UnitDefs = [{ BaseID = "Unit.DirewolfBodyguard" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
