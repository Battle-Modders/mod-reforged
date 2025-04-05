local unitBlocks = [
	// Purebred Beasts
	{
		ID = "UnitBlock.RF.Direwolf",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Direwolf" }, { BaseID = "Unit.RF.DirewolfHIGH" }]
		}
	},
	{
		ID = "UnitBlock.RF.GhoulLowOnly",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.GhoulLOW" }]
		}
	},
	{
		ID = "UnitBlock.RF.Ghoul",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.GhoulLOW" },
				{ BaseID = "Unit.RF.Ghoul", RatioMax = 0.7 },
				{ BaseID = "Unit.RF.GhoulHIGH", RatioMax = 0.2 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.Lindwurm",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Lindwurm" }]
		}
	},
	{
		ID = "UnitBlock.RF.Unhold",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Unhold" }]
		}
	},
	{
		ID = "UnitBlock.RF.UnholdFrost",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.UnholdFrost" }]
		}
	},
	{
		ID = "UnitBlock.RF.UnholdBog",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.UnholdBog" }]
		}
	},
	{
		ID = "UnitBlock.RF.Spider",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Spider" }]
		}
	},
	{
		ID = "UnitBlock.RF.Alp",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Alp" }]
		}
	},
	{
		ID = "UnitBlock.RF.Schrat",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Schrat" }]
		}
	},
	// Vanilla Kraken skipped at this point
	{
		ID = "UnitBlock.RF.Hyena",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Hyena" }, { BaseID = "Unit.RF.HyenaHIGH" }]
		}
	},
	{
		ID = "UnitBlock.RF.Serpent",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Serpent" }]
		}
	},
	{
		ID = "UnitBlock.RF.SandGolem",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.SandGolem" }, { BaseID = "Unit.RF.SandGolemMEDIUM" }, { BaseID = "Unit.RF.SandGolemHIGH" }]
		}
	},

// Mixed Beasts
	{
		ID = "UnitBlock.RF.HexeNoBodyguard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Hexe" }]
		}
	},
	{
		ID = "UnitBlock.RF.HexeWithBodyguard",
		StartingResourceMin = 300,
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Hexe" }, { BaseID = "Unit.RF.HexeOneSpider" }, { BaseID = "Unit.RF.HexeTwoSpider" }, { BaseID = "Unit.RF.HexeOneDirewolf" }, { BaseID = "Unit.RF.HexeTwoDirewolf" }]
		}
	},
	{
		ID = "UnitBlock.RF.HexeNoSpider",
		StartingResourceMin = 300,
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Hexe" }, { BaseID = "Unit.RF.HexeOneDirewolf" }, { BaseID = "Unit.RF.HexeTwoDirewolf" }]
		}
	},
	{
		ID = "UnitBlock.RF.HexeBandit",	// Spawn in HexenFights
		StartingResourceMin = 200,
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BanditRaider" }]
		}
	},
	{
		ID = "UnitBlock.RF.HexeBanditRanged",	// Spawn in HexenFights. In Vanilla they only ever spawn a single marksman alongside several raiders. Never more
		StartingResourceMin = 200,
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BanditMarksman" }]
		}
	},

// Bodyguards
	{
		ID = "UnitBlock.RF.SpiderBodyguard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.SpiderBodyguard" }]
		}
	},
	{
		ID = "UnitBlock.RF.DirewolfBodyguard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.DirewolfBodyguard" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
