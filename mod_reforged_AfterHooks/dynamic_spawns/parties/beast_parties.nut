local parties = [
	{
		// Vanilla: Size 3-26, Cost 60-650
		// 17/17/9    105 resources = first wolf/high.   535 = last wolf/high. 8 High is first High only.
		ID = "Direwolves",
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			Units = [ // Used units instead of blocks because sometimes one or the other unit is missing.
				{ BaseID = "Unit.RF.Direwolf", //RatioMin = 0.00, RatioMax = 1.00
				},
				{ BaseID = "Unit.RF.DirewolfHIGH", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 120
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() > 400 ? 0.8 : 0.12); }
				}
			]
		}

		function onBeforeSpawnStart()
		{
			if (this.getTopParty().getStartingResources() > 535) // no more standard Direwolves over 535 resources
				{
					this.getSpawnable("Unit.RF.Direwolf").HardMax = 0;
				}
			else // under 535 resources. 20% High only, 40% mixed, 40% Direwolf only
				{
				local r = ::Math.rand(1, 100);
				if (r < 40)
				{
					if (this.getTopParty().getStartingResources() > 175) // want a chance for there to be 0 standard Direwolves over 175 resources
					{
						this.getSpawnable("Unit.RF.Direwolf").HardMax = 0;
					}
				}
				else if (r > 80)
				{
					this.getSpawnable("Unit.RF.DirewolfHIGH").HardMax = 0;
				}
			}
		}
	},
	{
		// Vanilla: Size 1-25, Cost 45-484; Vanilla has a spawn with 1 ghoul high only. Also appears in 5/0/1
        ID = "Ghouls",
        HardMin = 5,
        DefaultFigure = "figure_ghoul_01",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
        	UnitBlocks = [
        		{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00 }
        	]
        }
	},
	{
		ID = "Lindwurm",
		HardMin = 1,
		DefaultFigure = "figure_lindwurm_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Lindwurm", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Unhold",
		HardMin = 1,
		DefaultFigure = "figure_unhold_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "UnholdFrost",
		HardMin = 1,
		DefaultFigure = "figure_unhold_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.UnholdFrost", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "UnholdBog",
		HardMin = 1,
		DefaultFigure = "figure_unhold_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Spiders",
		HardMin = 1,
		DefaultFigure = "figure_spider_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Spider", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Alps",
		HardMin = 3,
		DefaultFigure = "figure_alp_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Alp", RatioMin = 0.00, RatioMax = 1.00 },
				// Vanilla spawns Direwolf at 110 resources and DirwolfHIGH at 395 resources. Both with roughly RatioMax = 0.35.
				// Direwolf is excluded in 77% of parties above those resources and DirewolfHIGH is excluded in 50%.
				{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 0.35, ExclusionChance = 0.8, DeterminesFigure = false },
				// We add Hollenhund into the mix as well with similar spawning behavior as that of Direwolves.
				// Some parties will contain both Direwolves and Hollenhunds.
				{ BaseID = "UnitBlock.RF.Hollenhund", RatioMin = 0.00, RatioMax = 0.35, ExclusionChance = 0.8, DeterminesFigure = false }
			]
		}
	},
	{
		ID = "Schrats",
		HardMin = 1,
		DefaultFigure = "figure_schrat_01",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "HexenAndMore",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.Hexe" }	// This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.HexeWithBodyguard", RatioMin = 0.00, RatioMax = 0.13, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Spider", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.HexeBandit", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.HexeBanditRanged", RatioMin = 0.00, RatioMax = 0.13, DeterminesFigure = false }
			]
		}
	},
	{
		ID = "HexenAndNoSpiders",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.Hexe" }	// This one has no Bodyguards, which is not perfect because sometimes the only Hexe spawns with bodyguards in vanilla
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.HexeNoSpider", RatioMin = 0.00, RatioMax = 0.13, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 80, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Schrat", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 300, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Unhold", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 200, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.UnholdBog", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 250, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Direwolf", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.HexeBandit", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = false }
			]
		}
	},
	{
		ID = "Hexen",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.HexeNoBodyguard", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},

	// Skipped Kraken
	{
		ID = "Hyenas",
		HardMin = 3,
		UpgradeFactor = 2.8,
		DefaultFigure = "figure_hyena_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Hyena", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Serpents",
		HardMin = 3,
		DefaultFigure = "figure_serpent_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Serpent", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "SandGolems",
		HardMin = 3,
		DefaultFigure = "figure_golem_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SandGolem", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	}

	// SubParties
	{
		ID = "SpiderBodyguards",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SpiderBodyguard" }
			]
		}
	},
	{
		ID = "DirewolfBodyguards",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.DirewolfBodyguard" }
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
