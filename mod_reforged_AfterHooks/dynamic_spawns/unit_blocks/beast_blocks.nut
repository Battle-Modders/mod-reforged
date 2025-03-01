local unitBlocks = [
	// Purebred Beasts
	{
		ID = "UnitBlock.RF.Direwolf",
		UnitDefs = [{ BaseID = "Unit.RF.Direwolf" }, { BaseID = "Unit.RF.DirewolfHIGH" }]
	},
	{
		ID = "UnitBlock.RF.GhoulLowOnly",
		UnitDefs = [{ BaseID = "Unit.RF.GhoulLOW" }]
	},
	{
		ID = "UnitBlock.RF.Ghoul",
		UnitDefs = [
			{ BaseID = "Unit.RF.GhoulLOW" },
			{ BaseID = "Unit.RF.Ghoul", function getHardMax() {
					return ::Math.min(base.getHardMax(), this.getSpawnProcess().getTotal() * 0.7);
				}
			},
			{ BaseID = "Unit.RF.GhoulHIGH", function getHardMax() {
					return ::Math.min(base.getHardMax(), this.getSpawnProcess().getTotal() * 0.2);
				}
			}
		]
	},
	{
		ID = "UnitBlock.RF.Lindwurm",
		UnitDefs = [{ BaseID = "Unit.RF.Lindwurm" }]
	},
	{
		ID = "UnitBlock.RF.Unhold",
		UnitDefs = [{ BaseID = "Unit.RF.Unhold" }]
	},
	{
		ID = "UnitBlock.RF.UnholdFrost",
		UnitDefs = [{ BaseID = "Unit.RF.UnholdFrost" }]
	},
	{
		ID = "UnitBlock.RF.UnholdBog",
		UnitDefs = [{ BaseID = "Unit.RF.UnholdBog" }]
	},
	{
		ID = "UnitBlock.RF.Spider",
		UnitDefs = [{ BaseID = "Unit.RF.Spider" }]
	},
	{
		ID = "UnitBlock.RF.Alp",
		UnitDefs = [{ BaseID = "Unit.RF.Alp" }]
	},
	{
		ID = "UnitBlock.RF.Schrat",
		UnitDefs = [{ BaseID = "Unit.RF.Schrat" }]
	},
	// Vanilla Kraken skipped at this point
	{
		ID = "UnitBlock.RF.Hyena",
		UnitDefs = [{ BaseID = "Unit.RF.Hyena" }, { BaseID = "Unit.RF.HyenaHIGH" }]
	},
	{
		ID = "UnitBlock.RF.Serpent",
		UnitDefs = [{ BaseID = "Unit.RF.Serpent" }]
	},
	{
		ID = "UnitBlock.RF.SandGolem",
		UnitDefs = [{ BaseID = "Unit.RF.SandGolem" }, { BaseID = "Unit.RF.SandGolemMEDIUM" }, { BaseID = "Unit.RF.SandGolemHIGH" }]
	},

// Mixed Beasts
	{
		ID = "UnitBlock.RF.HexeNoBodyguard",
		UnitDefs = [{ BaseID = "Unit.RF.Hexe" }]
	},
	{
		ID = "UnitBlock.RF.HexeWithBodyguard",
		StartingResourceMin = 300,
		UnitDefs = [{ BaseID = "Unit.RF.Hexe" }, { BaseID = "Unit.RF.HexeOneSpider" }, { BaseID = "Unit.RF.HexeTwoSpider" }, { BaseID = "Unit.RF.HexeOneDirewolf" }, { BaseID = "Unit.RF.HexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.RF.HexeNoSpider",
		StartingResourceMin = 300,
		UnitDefs = [{ BaseID = "Unit.RF.Hexe" }, { BaseID = "Unit.RF.HexeOneDirewolf" }, { BaseID = "Unit.RF.HexeTwoDirewolf" }]
	},
	{
		ID = "UnitBlock.RF.HexeBandit",	// Spawn in HexenFights
		StartingResourceMin = 200,
		UnitDefs = [{ BaseID = "Unit.RF.BanditRaider" }]
	},
	{
		ID = "UnitBlock.RF.HexeBanditRanged",	// Spawn in HexenFights. In Vanilla they only ever spawn a single marksman alongside several raiders. Never more
		StartingResourceMin = 200,
		UnitDefs = [{ BaseID = "Unit.RF.BanditMarksman" }]
	},

// Bodyguards
	{
		ID = "UnitBlock.RF.SpiderBodyguard",
		UnitDefs = [{ BaseID = "Unit.RF.SpiderBodyguard" }]
	},
	{
		ID = "UnitBlock.RF.DirewolfBodyguard",
		UnitDefs = [{ BaseID = "Unit.RF.DirewolfBodyguard" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
