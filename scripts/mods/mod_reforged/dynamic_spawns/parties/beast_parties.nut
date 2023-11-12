local parties = [
	{
		ID = "Direwolves",
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Lindwurm", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.UnholdFrost", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Spider", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Alp", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "Unit.RF.Hexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.HexeWithBodyguard", RatioMin = 0.00, RatioMax = 0.13 },
			{ BaseID = "UnitBlock.RF.Spider", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.HexeBandit", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.HexeBanditRanged", RatioMin = 0.00, RatioMax = 0.13 }
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
			{ BaseID = "Unit.RF.Hexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.HexeNoSpider", RatioMin = 0.00, RatioMax = 0.13 },
			{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 80 },
			{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.HexeBandit", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.HexeNoBodyguard", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Hyena", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.Serpent", RatioMin = 0.00, RatioMax = 1.00 }
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
			{ BaseID = "UnitBlock.RF.SandGolem", RatioMin = 0.00, RatioMax = 1.00 }
		]
	}

	// SubParties
	{
		ID = "SpiderBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.SpiderBodyguard" }
		]
	},
	{
		ID = "DirewolfBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.DirewolfBodyguard" }
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
