local units = [
	{
		ID = "Unit.RF.Direwolf",
		Troop = "Direwolf",
		Figure = "figure_werewolf_01"
	},
	{
		ID = "Unit.RF.DirewolfHIGH",
		Troop = "DirewolfHIGH",
		Figure = "figure_werewolf_01",
		StartingResourceMin = 95		// In Vanilla this is 95
	},
	{
		ID = "Unit.RF.GhoulLOW",
		Troop = "GhoulLOW",
		Figure = "figure_ghoul_01"
	},
	{
		ID = "Unit.RF.Ghoul",
		Troop = "Ghoul",
		Figure = "figure_ghoul_01",
		StartingResourceMin = 150	// In vanilla this is 120
	},
	{
		ID = "Unit.RF.GhoulHIGH",
		Troop = "GhoulHIGH",
		Figure = "figure_ghoul_02",     // I don't know if a 'figure_ghoul_03' exists
		StartingResourceMin = 220	// In vanilla this is 120
	},
	{
		ID = "Unit.RF.Lindwurm",
		Troop = "Lindwurm",
		Figure = "figure_lindwurm_01"
	},
	{
		ID = "Unit.RF.Unhold",
		Troop = "Unhold",
		Figure = "figure_unhold_01"
	},
	{
		ID = "Unit.RF.UnholdFrost",
		Troop = "UnholdFrost",
		Figure = "figure_unhold_02"
	},
	{
		ID = "Unit.RF.UnholdBog",
		Troop = "UnholdBog",
		Figure = "figure_unhold_03"
	},
	{
		ID = "Unit.RF.Spider",
		Troop = "Spider",
		Figure = "figure_spider_01"
	},
	{
		ID = "Unit.RF.Alp",
		Troop = "Alp",
		Figure = "figure_alp_01"
	},
	{
		ID = "Unit.RF.Schrat",
		Troop = "Schrat",
		Figure = "figure_schrat_01"
	},
	{
		ID = "Unit.RF.Kraken",
		Troop = "Kraken"
	},
	{
		ID = "Unit.RF.Hyena",
		Troop = "Hyena",
		Figure = "figure_hyena_01"
	},
	{
		ID = "Unit.RF.HyenaHIGH",
		Troop = "HyenaHIGH",
		Figure = "figure_hyena_01",
		StartingResourceMin = 125		// In Vanilla this is 125
	},
	{
		ID = "Unit.RF.Serpent",
		Troop = "Serpent",
		Figure = "figure_serpent_01"
	},
	{
		ID = "Unit.RF.SandGolem",
		Troop = "SandGolem",
		Figure = "figure_golem_01"
	},
	{
		ID = "Unit.RF.SandGolemMEDIUM",
		Troop = "SandGolemMEDIUM",
		Figure = "figure_golem_01",
		Cost = 42   // 35 in Vanilla, 3 Small Golems should cost slightly less than 1 Medium Golem because they always spend their first turn action morphing
	},
	{	// In Vanilla these never spawn naturally as part of the line-up
		ID = "Unit.RF.SandGolemHIGH",
		Troop = "SandGolemHIGH",
		Figure = "figure_golem_02",    // I don't know if a 'figure_golem_03' exists
		Cost = 129   // 70 in Vanilla, -!!-
	}

	// Possible Hexen
	{
		ID = "Unit.RF.Hexe",      // Without Bodyguards
		Troop = "Hexe",
		Figure = "figure_hexe_01"
	},
	{
		ID = "Unit.RF.HexeOneSpider",
		Troop = "Hexe",
		Figure = "figure_hexe_01",
		Cost = 50,
		SubPartyDef = {BaseID = "SpiderBodyguards", HardMin = 1, HardMax = 1, IsUsingTopPartyResources = false}
	},
	{
		ID = "Unit.RF.HexeTwoSpider",
		Troop = "Hexe",
		Figure = "figure_hexe_01",
		Cost = 50,
		SubPartyDef = {BaseID = "SpiderBodyguards", HardMin = 2, HardMax = 2, IsUsingTopPartyResources = false}
	},
	{
		ID = "Unit.RF.HexeOneDirewolf",
		Troop = "Hexe",
		Figure = "figure_hexe_01",
		Cost = 50,
		SubPartyDef = {BaseID = "DirewolfBodyguards", HardMin = 1, HardMax = 1, IsUsingTopPartyResources = false}
	},
	{
		ID = "Unit.RF.HexeTwoDirewolf",
		Troop = "Hexe",
		Figure = "figure_hexe_01",
		Cost = 50,
		SubPartyDef = {BaseID = "DirewolfBodyguards", HardMin = 2, HardMax = 2, IsUsingTopPartyResources = false}
	},

	// Bodyguards
	{
		ID = "Unit.RF.SpiderBodyguard",
		Troop = "SpiderBodyguard"
	},
	{
		ID = "Unit.RF.DirewolfBodyguard",
		Troop = "DirewolfBodyguard"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
