local parties = [
	{
		ID = "ZombieOrcs",
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieOrcYoung", RatioMin = 0.15, RatioMax = 1.00
					function getSpawnWeight() {	// Lategame Parties will have fewer Young in them
						return base.getSpawnWeight() * ::Math.maxf(0.1, (1.0 - 0.0001 * ::Math.pow(this.getTopParty().getStartingResources(), 1.55)));
					}
				},
				{ BaseID = "UnitBlock.RF.ZombieOrcBerserker", RatioMin = 0.00, RatioMax = 0.45,
					function getExclusionChance() {return this.getParty().getStartingResources() < 225 ? 0.7 : 0.5; },
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5 }
				},
				{ BaseID = "UnitBlock.RF.ZombieOrcWarrior", RatioMin = 0.00, RatioMax = 0.80,
					function getExclusionChance() {return this.getParty().getStartingResources() < 225 ? 0.6 : 0.3; },
					function getSpawnWeight() { return base.getSpawnWeight() *  2.0 }
				},
				{ BaseID = "UnitBlock.RF.ZombieOrcWarlord", RatioMin = 0.00, HardMax = 1,
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() >= 350 ? 0.05 : 0.01); }
				}
			]
		}
	},
	{
		// Vanilla: Size 6-38, Cost 36-516
		ID = "Zombies", // Spawn in Investigate Cemetary Contract, Last Stand Contract
		HardMin = 6,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieFrontline" }
			]
		},

		function getUpgradeChance()
		{
			return 20 + 2.25 * this.getTotal();
		}
	},
	{
		// Vanilla: Size 4-23, Cost 80-460
		ID = "Ghosts",
		HardMin = 4,
		DefaultFigure = "figure_ghost_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 0.75,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Ghost" },
				{ BaseID = "UnitBlock.RF.Banshee", ExclusionChance = 0.66 }
			]
		}
	},
	{
		// Vanilla: Size 7-32, Cost 54-435
		ID = "ZombiesAndGhouls",
		HardMin = 7,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GhoulLowOnly", RatioMin = 0.15, RatioMax = 0.30 }
			]
		},

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.ZombieKnight").StartingResourceMin = 175; // Vanilla 176
			this.getSpawnable("Unit.RF.RF_ZombieHero").StartingResourceMin = 225;
		}

		function getUpgradeChance()
		{
			return 5 + 3.25 * this.getTotal();
		}
	},
	{
		// Vanilla: Size 7-32, Cost 76-512
		ID = "ZombiesAndGhosts", // Spawn in Last Stand Contract
		HardMin = 7,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.14, RatioMax = 0.3 },
				{ BaseID = "UnitBlock.RF.Hollenhund", RatioMin = 0.00, RatioMax = 0.15, ExclusionChance = 0.33 },
				{ BaseID = "UnitBlock.RF.Banshee", RatioMin = 0.00, ExclusionChance = 0.75 }
			]
		},

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.ZombieKnight").StartingResourceMin = 250; // Vanilla 266
			this.getSpawnable("Unit.RF.RF_ZombieHero").StartingResourceMin = 300;
		}

		function getUpgradeChance()
		{
			return 40 + 1.25 * this.getTotal();
		}
	},
	{
		// Can spawn in Raid Caravan Contract (5%), as secondary objective in Investigate Cemetary Contract
		// and in Undead Crypt, Necromancer's Lair and Undead Ruins locations.
		ID = "Necromancer",
		Variants = ::MSU.Class.WeightedContainer([
			[4, {
					ID ="Necromancer_0"
					HardMin = 10,
					DefaultFigure = "figure_necromancer_01",
					MovementSpeedMult = 1.0,
					VisibilityMult = 1.0,
					VisionMult = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.NecromancerWithBodyguards",
								function onBeforeSpawnStart()
								{
									local c = ::MSU.Class.WeightedContainer();
									c.add(1, 80);
									if (this.getTopParty().getStartingResources() >= 500) // Vanilla has a 2 Necromancer party at 494 resources
									{
										c.add(2, 20); // Output, Weight
									}

									this.HardMin = c.roll();
									this.HardMax = this.HardMin;
								}
							},
							{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.30, RatioMax = 1.00, DeterminesFigure = false },
							{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.33, DeterminesFigure = false },
							{ BaseID = "UnitBlock.RF.Hollenhund", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.50, DeterminesFigure = false },
							{ BaseID = "UnitBlock.RF.Banshee", RatioMin = 0.00, ExclusionChance = 0.75, DeterminesFigure = false }
						],
						Parties = [
							{ BaseID = "ZombieOrcs", RatioMax = 0.2, ExclusionChance = 0.8, DeterminesFigure = false }
						]
					}
				}
			],
			[1, {
					ID ="NecromancerZombieOrc"
					HardMin = 6,
					DefaultFigure = "figure_necromancer_01",
					MovementSpeedMult = 1.0,
					VisibilityMult = 1.0,
					VisionMult = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.NecromancerWithBodyguardsOrc",
								function onBeforeSpawnStart()
								{
									local c = ::MSU.Class.WeightedContainer([
										[80, 1], // Weight, Output
									]);

									if (this.getTopParty().getStartingResources() >= 500) // Vanilla has a 2 Necromancer party at 494 resources
									{
										c.add(2, 20); // Output, Weight
									}

									this.HardMin = c.roll();
									this.HardMax = this.HardMin;
								}
							},
							{ BaseID = "UnitBlock.RF.Hollenhund", RatioMax = 0.20, ExclusionChance = 0.50, DeterminesFigure = false }
						],
						Parties = [
							{ BaseID = "ZombieOrcs", DeterminesFigure = false }
						]
					}
				}
			]
		])
	},
	{
		ID = "NecromancerSouthern", // Can spawn in Raid Caravan Contract (5%), as secondary objective in Investigate Cemetary Contract and in Undead Crypt, Necromancer's Lair and Undead Ruins locations.
		Variants = ::MSU.Class.WeightedContainer([
			[9, {
					ID = "NecromancerSouthern_0"
					HardMin = 4,
					DefaultFigure = "figure_necromancer_01",
					MovementSpeedMult = 1.0,
					VisibilityMult = 1.0,
					VisionMult = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.NecromancerWithBodyguardsNomad",
								function onBeforeSpawnStart()
								{
									local c = ::MSU.Class.WeightedContainer();
									c.add(1, 80);
									if (this.getTopParty().getStartingResources() >= 250) // Vanilla has a 2 Necromancer party at 246 resources
									{
										c.add(2, 20); // Output, Weight
									}

									this.HardMin = c.roll();
									this.HardMax = this.HardMin;
								}
							},
							{ BaseID = "UnitBlock.RF.ZombieFrontlineSouthern", RatioMin = 0.30, RatioMax = 1.00, DeterminesFigure = false },
							{ BaseID = "UnitBlock.RF.Hollenhund", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.33, DeterminesFigure = false }
						],
						Parties = [
							{ BaseID = "ZombieOrcs", RatioMax = 0.2, ExclusionChance = 0.8, DeterminesFigure = false }
						]

					}
				}],
			[1, {
					ID = "NecromancerSouthernZombieOrc"
					DefaultFigure = "figure_necromancer_01",
					MovementSpeedMult = 1.0,
					VisibilityMult = 1.0,
					VisionMult = 1.0,
					DynamicDefs = {
						Parties = [
							{ BaseID = "NecromancerZombieOrc" }
						]
					}
				}]
			])
	},
	{	// Only un-armored zombies
		ID = "ZombiesLight",
		HardMin = 6,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieLight" }
			]
		}
	}

	// SubParties
	{
		ID = "NecromancerBodyguards",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieBodyguard", RatioMin = 0.00, RatioMax = 1.00 }, // Check onBeforeSpawnStart for Exclusions
				{ BaseID = "UnitBlock.RF.ZombieBodyguardOrc", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}

		function getDefaultResources()
		{
			return this.getTopParty() == this ? base.getDefaultResources() : this.getTopParty().getStartingResources() * 0.20 * ::MSU.Math.randf(0.8, 1.2);
		}

		function onBeforeSpawnStart()
		{
			local c = ::MSU.Class.WeightedContainer();
			c.add(2, 3);

			if (this.getTopParty().getStartingResources() < 200)
			{
				c.add(1, 0.5);
			}
			else
			{
				c.add(3, 1);
			}

			this.HardMin = c.roll();
			this.HardMax = this.HardMin;

			// 10% Orc only, 20% mixed, 70% Regular only
			local r = ::Math.rand(1, 100);
			if (r < 70)
			{
				this.getSpawnable("UnitBlock.RF.ZombieBodyguardOrc").HardMax = 0;
			}
			else if (r > 90)
			{
				this.getSpawnable("UnitBlock.RF.ZombieBodyguard").HardMax = 0;
			}
		}
	},
	{
		ID = "NecromancerBodyguardsNomad",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieBodyguardNomad", RatioMin = 0.00, RatioMax = 1.00 }, // Check onBeforeSpawnStart for Exclusions
				{ BaseID = "UnitBlock.RF.ZombieBodyguardOrc", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}

		function getDefaultResources()
		{
			return this.getTopParty() == this ? base.getDefaultResources() : this.getTopParty().getStartingResources() * 0.20 * ::MSU.Math.randf(0.8, 1.2);
		}

		function onBeforeSpawnStart()
		{
			local c = ::MSU.Class.WeightedContainer();
			c.add(2, 3);

			if (this.getTopParty().getStartingResources() < 200)
			{
				c.add(1, 0.5);
			}
			else
			{
				c.add(3, 1);
			}

			this.HardMin = c.roll();
			this.HardMax = this.HardMin;

			// 10% Orc only, 20% mixed, 70% Regular only
			local r = ::Math.rand(1, 100);
			if (r < 70)
			{
				this.getSpawnable("UnitBlock.RF.ZombieBodyguardOrc").HardMax = 0;
			}
			else if (r > 90)
			{
				this.getSpawnable("UnitBlock.RF.ZombieBodyguardNomad").HardMax = 0;
			}
		}
	},
	{
		ID = "NecromancerBodyguardsOrc",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.ZombieBodyguardOrc", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}

		function getDefaultResources()
		{
			return this.getTopParty() == this ? base.getDefaultResources() : this.getTopParty().getStartingResources() * 0.20 * ::MSU.Math.randf(0.8, 1.2);
		}

		function onBeforeSpawnStart()
		{
			local c = ::MSU.Class.WeightedContainer();
			c.add(2, 3);

			if (this.getTopParty().getStartingResources() < 200)
			{
				c.add(1, 0.5);
			}
			else
			{
				c.add(3, 1);
			}

			this.HardMin = c.roll();
			this.HardMax = this.HardMin;
		}
	},
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
