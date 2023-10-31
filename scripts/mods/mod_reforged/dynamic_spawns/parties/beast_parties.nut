local parties = [
	{
		ID = "Direwolves",
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.BeastDirewolves", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastGhouls", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastLindwurms", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastUnholds", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastUnholdsFrost", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastUnholdsBog", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastSpiders", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastAlps", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastSchrats", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastHexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.BeastHexenWithBodyguards", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.BeastSpiders", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.BeastGhouls", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.BeastSchrats", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.BeastUnholds", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.BeastUnholdsBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.BeastDirewolves", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.BeastHexenBandits", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.BeastHexenBanditsRanged", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 200 }
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
			{ BaseID = "UnitBlock.BeastHexe" }    // This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.BeastHexenNoSpiders", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.BeastGhouls", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 80 },
			{ BaseID = "UnitBlock.BeastSchrats", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300 },
			{ BaseID = "UnitBlock.BeastUnholds", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 },
			{ BaseID = "UnitBlock.BeastUnholdsBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250 },
			{ BaseID = "UnitBlock.BeastDirewolves", RatioMin = 0.00, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.BeastHexenBandits", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200 }
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
			{ BaseID = "UnitBlock.BeastHexenNoBodyguards", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastHyenas", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastSerpents", RatioMin = 0.00, RatioMax = 1.00}
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
			{ BaseID = "UnitBlock.BeastSandGolems", RatioMin = 0.00, RatioMax = 1.00}
		]
	}

	// SubParties
	{
		ID = "SpiderBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.BeastSpiderBodyguards"}
		]
	},
	{
		ID = "DirewolfBodyguards",
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.BeastDirewolfBodyguards"}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
