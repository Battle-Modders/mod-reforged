local parties = [
	{
		ID = "Direwolves",
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Direwolf", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Ghouls",
		HardMin = 5,
		DefaultFigure = "figure_ghoul_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Ghoul", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Lindwurm",
		HardMin = 1,
		DefaultFigure = "figure_lindwurm_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Lindwurm", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Unhold",
		HardMin = 1,
		DefaultFigure = "figure_unhold_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Unholds", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "UnholdFrost",
		HardMin = 1,
		DefaultFigure = "figure_unhold_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.UnholdFrost", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "UnholdBog",
		HardMin = 1,
		DefaultFigure = "figure_unhold_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.UnholdBog", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Spiders",
		HardMin = 1,
		DefaultFigure = "figure_spider_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Spider", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Alps",
		HardMin = 3,
		DefaultFigure = "figure_alp_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Alp", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Schrats",
		HardMin = 1,
		DefaultFigure = "figure_schrat_01",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Schrat", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "HexenAndMore",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.Hexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.HexeWithBodyguard", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.Spider", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.Ghoul", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.Schras", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.Direwolf", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.HexeBandit", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.HexenBanditRanged", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 200 }
		]
	},
	{
		ID = "HexenAndNoSpiders",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.Hexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.HexeNoSpider", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.Ghoul", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 80 },
			{ BaseID = "UnitBlock.Schrat", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.Direwolf", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.HexeBandit", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 }
		]
	},
	{
		ID = "Hexen",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.HexeNoBodyguard", RatioMin = 0.00, RatioMax = 1.00}
		]
	},

	// Skipped Kraken
	{
		ID = "Hyenas",
		HardMin = 3,
		DefaultFigure = "figure_hyena_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Hyena", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "Serpents",
		HardMin = 3,
		DefaultFigure = "figure_serpent_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Serpent", RatioMin = 0.00, RatioMax = 1.00}
		]
	},
	{
		ID = "SandGolems",
		HardMin = 3,
		DefaultFigure = "figure_golem_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.SandGolem", RatioMin = 0.00, RatioMax = 1.00}
		]
	}

	// SubParties
	{
		ID = "SpiderBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.SpiderBodyguard"}
		]
	},
	{
		ID = "DirewolfBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.DirewolfBodyguard"}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
