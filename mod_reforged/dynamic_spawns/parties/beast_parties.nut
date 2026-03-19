local parties = [
	{
		// Vanilla: Size 3-26, Cost 60-650
		// Vanilla has some parties with DirewolfHIGH only. The first of these is at 8 DirewolfHIGH.
		ID = "Direwolves",
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Direwolf" }
			]
		}

		function onBeforeSpawnStart()
		{
			local direwolf = this.getSpawnable("Unit.RF.Direwolf");
			local high = this.getSpawnable("Unit.RF.DirewolfHIGH");
			local res = this.getTopParty().getStartingResources();

			direwolf.StartingResourceMax = 535;
			high.StartingResourceMin = 125;
			// When both regular and high can spawn then:
			// 18% chance to be high only (only at >175 resources).
			// 29% chance to be regular only
			// 53% chance to be both
			if (res > high.StartingResourceMin && res < direwolf.StartingResourceMax)
			{
				if (res > 175 && ::Math.rand(1, 100) < 18)
				{
					direwolf.HardMax = 0;
				}
				else
				{
					high.ExclusionChance = 0.35;
				}
			}
		}

		function getUpgradeChance()
		{
			return 10 + 1.75 * this.getTotal();
		}
	}
	{
		// Vanilla: Size 1-28, Cost 30-484; Vanilla has a spawn with 1 ghoul high only. Also appears in 5/0/1
		// Without that 1 GhoulHIGH party the actual vanilla info is: Size 5-28, Cost 45-484
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
		},

		function onBeforeSpawnStart()
		{
			local low = this.getSpawnable("Unit.RF.GhoulLOW");
			local med = this.getSpawnable("Unit.RF.Ghoul");
			local high = this.getSpawnable("Unit.RF.GhoulHIGH");

			low.RatioMin = 0.2;
			med.StartingResourceMin = 112;
			med.RatioMax = 0.4;
			high.StartingResourceMin = 112;
			high.RatioMax = 0.4;
			high.ExclusionChance = 0.3;
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 10 + res / 50.0 + (1 + res / 350.0) * this.getTotal();
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
		// Vanilla: Size 3-17, Cost 90-480
		ID = "Alps",
		HardMin = 3,
		DefaultFigure = "figure_alp_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Alp", RatioMin = 0.65, RatioMax = 1.00, HardMin = 3 }
			],
			Parties = [
				{
					// Vanilla spawns Direwolf at 110 resources and DirwolfHIGH at 395 resources. Both with RatioMax = 0.35.
					// Direwolf is excluded in 77% of parties above those resources and DirewolfHIGH is excluded in 50%. 75% of parties
					// above the first direwolf party are without any wolves.
					// We add Hollenhund as an alternative. We will spawn either Direwolves or Hollenhunds, but not both together.
					ID = "Animals", RatioMax = 0.35, ExclusionChance = 0.75, DeterminesFigure = false,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Direwolf" },
							{ BaseID = "UnitBlock.RF.Hollenhund" }
						]
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.DirewolfHIGH").StartingResourceMin = 395;
			// More chance to have Animals at higher resources.
			if (this.getTopParty().getStartingResources() >= 395)
			{
				this.getSpawnable("Animals").ExclusionChance = 0.5;
			}

			local hollenhunds = this.getSpawnable("UnitBlock.RF.Hollenhund");
			if (hollenhunds.isValid() && hollenhunds.canSpawn())
			{
				// 50% chance to be either Direwolves or Hollenhunds.
				if (::Math.rand(1, 2) == 1)
				{
					hollenhunds.HardMax = 0;
				}
				else
				{
					this.getSpawnable("UnitBlock.RF.Direwolf").HardMax = 0;
				}
			}
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
		// Vanilla: Size 2-20, Cost 10-500
		ID = "HexenAndMore",
		HardMin = 2,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				// HardMax is rolled and set manually in onBeforeSpawnStart
				{ BaseID = "UnitBlock.RF.Hexe", RatioMin = 0.00, RatioMax = 0.75, HardMin = 1, HardMax = 3 },
			],
			Parties = [
				{
					ID = "Bandits",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.00, RatioMax = 1.00 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.5 },
							{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.3 },
							{ BaseID = "UnitBlock.RF.DirewolfBodyguard", RatioMin = 0.00, RatioMax = 0.2 },
						]
					}
				},
				{
					ID = "Spiders",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Spider" },
							{ BaseID = "UnitBlock.RF.SpiderBodyguard", RatioMax = 0.2 }
						]
					}
				},
				{
					ID = "Ghouls",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Ghoul" }
						]
					}
				},
				{
					ID = "Direwolves",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Direwolf" },
							{ BaseID = "UnitBlock.RF.DirewolfBodyguard", RatioMax = 0.2 },
						]
					}
				},
				{
					ID = "Unholds",
					DynamicDefs = {
						Parties = [
							{
								ID = "UnholdOrUnholdBog", HardMax = 5,
								DynamicDefs = {
									UnitBlocks = [
										{ BaseID = "UnitBlock.RF.Unhold" },
										{ BaseID = "UnitBlock.RF.UnholdBog" }
									]
								}
							}
						],
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Direwolf", StartingResourceMin = 350 } // Higher cost parties will include Direwolves as well
						]
					}
				},
				{
					ID = "Schrats",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.Schrat", HardMax = 5 },
							{ BaseID = "UnitBlock.RF.Direwolf", StartingResourceMin = 350 } // Higher cost parties will include Direwolves as well
						]
					}
				}
			]
		},

		function getUpgradeChance()
		{
			return 40;
		}

		function onBeforeSpawnStart()
		{
			// Higher chance to be fewer Hexen
			this.getSpawnable("UnitBlock.RF.Hexe").HardMax = ::MSU.Class.WeightedContainer([
				[6, 1], [4, 2], [2, 3],	[1, 4]
			]).roll();

			// Choose ONE of the various combinations of additional units.
			local self = this;
			local potential = ["Bandits", "Spiders", "Ghouls", "Direwolves", "Unholds",	"Schrats"]
								.map(@(_id) self.getSpawnable(_id))
								.filter(@(_, _spawnable) _spawnable.isValid() && _spawnable.canSpawn());

			if (potential.len() != 0)
			{
				local chosen = ::MSU.Array.rand(potential);
				foreach (spawnable in potential)
				{
					if (spawnable != chosen)
					{
						spawnable.HardMax = 0;
					}
				}
			}

			// 20% chance to be Unhold and UnholdBog mix. Otherwise either Unhold only or UnholdBog only.
			local unholds = this.getSpawnable("Unholds");
			if (::Math.rand(1, 100) <= 80)
			{
				if (::Math.rand(1, 2) == 1)
					unholds.getSpawnable("UnitBlock.RF.UnholdBog").HardMax = 0;
				else
					unholds.getSpawnable("UnitBlock.RF.Unhold").HardMax = 0;
			}
		}
	},
	{
		// Vanilla: Size 2-15, Cost 100-500
		ID = "HexenAndNoSpiders",
		HardMin = 2,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			Parties = [
				{ BaseID = "HexenAndMore" }
			]
		},

		function onBeforeSpawnStart()
		{
			this.getSpawnable("UnitBlock.RF.Spider").HardMax = 0;
		}
	},
	{
		// Vanilla: Size 1-9, Cost 50-450
		ID = "Hexen",
		HardMin = 1,
		DefaultFigure = "figure_hexe_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Hexe", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},

	// Skipped Kraken
	{
		// Vanilla: Size 3-26, Cost 60-650
		ID = "Hyenas",
		HardMin = 3,
		DefaultFigure = "figure_hyena_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Hyena", RatioMin = 0.00, RatioMax = 1.00 }
			]
		},

		function getUpgradeChance()
		{
			return 10 + 1.25 * this.getTotal() + (this.getTopParty().getStartingResources() > 400 ? 15 : 0);
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
		// Vanilla: Size 3-42, Cost 39-546
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
		},

		function getUpgradeChance()
		{
			return 20;
		}

		function onBeforeSpawnStart()
		{
			// Vanilla never spawns SandGolemHIGH in the party
			this.getSpawnable("Unit.RF.SandGolemHIGH").HardMax = 0;

			// Vanilla doesn't have more than 29% SandGolemHIGH in any party
			this.getSpawnable("Unit.RF.SandGolemMEDIUM").RatioMax = 0.3;

			// 45% chance to have only small golems. This is similar to vanilla spawnlist.
			if (::Math.rand(1, 100) < 45)
			{
				this.getSpawnable("Unit.RF.SandGolemMEDIUM").HardMax = 0;
			}
		}
	},

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
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
