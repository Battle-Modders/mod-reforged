local parties = [
	{
		// Vanilla: Size 5-16, Cost 56-220
		ID = "BanditRoamers", // Spawn from patrol contract and send bandit raomers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			Parties = [
				{
					ID = "Frontline",
					RatioMin = 0.3,
					RatioMax = 0.6,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.0, RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.35, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.40 }
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = ::Math.max(10, this.getTopParty().getStartingResources() * 0.3);
		}
	},
	{
		// Vanilla: Size 6-18, Cost 61-170
		ID = "BanditScouts", // Only spawn from restore location contract
		HardMin = 7,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		IdealSizeLocationMult = 1.2,
		DynamicDefs = {
			Parties = [
				{
					ID = "Frontline",
					RatioMin = 0.4,
					RatioMax = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.0, RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 0.20 },
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.6 }
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = 10 + ::Math.max(10, this.getTopParty().getStartingResources() * 0.3);
		}
	},
	{
		// Vanilla: Size 5-28, Cost 63-600
		ID = "BanditRaiders",  // Spawn from defend settlment contract, discover location contract, escort caravan contract, investigate cemetary contract, patrol contract, return item contract, root out undead contract and send bandit ambushers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		IdealSizeLocationMult = 1.2,
		DynamicDefs = {
			Parties = [
				{
					ID = "Frontline",
					RatioMin = 0.45,
					RatioMax = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.0, RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.50, ExclusionChance = 0.20 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.13, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 0.5 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140,
					function onBeforeSpawnStart()
					{
						this.ExclusionChance = 100.0 / this.getTopParty().getStartingResources();
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = 50 + this.getTopParty().getStartingResources() * 0.02;
		}
	},
	{
		// Vanilla: Size 4-28, Cost 45-585
		ID = "BanditDefenders",  // Spawn from deliver item contract, drive away bandits contract, bandit camp locations, bandit hideout locations, bandit ruins locations, man in forest event and defend bandits action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		IdealSizeLocationMult = 1.2,
		DynamicDefs = {
			Parties = [
				{
					ID = "Frontline",
					RatioMin = 0.45,
					RatioMax = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.0, RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.55, ExclusionChance = 0.2 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.15, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 0.65 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140,
					function onBeforeSpawnStart()
					{
						this.ExclusionChance = 100.0 / this.getTopParty().getStartingResources();
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = 50 + this.getTopParty().getStartingResources() * 0.01;
		}
	},
	{
		// Vanilla: Size 7-28, Cost 145-585
		ID = "BanditBoss",
		HardMin = 9,
		DefaultFigure = "figure_bandit_04",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		IdealSizeLocationMult = 1.2,
		DynamicDefs = {
			Parties = [
				{
					ID = "Frontline",
					RatioMin = 0.5,
					RatioMax = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.0, RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 0.1 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.2, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 0.5 },
				{ BaseID = "UnitBlock.RF.BanditBoss", HardMin = 1, HardMax = 3, RatioMin = 0.00, RatioMax = 0.15 }  // One boss is always guaranteed
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = 50 + this.getTopParty().getStartingResources() * 0.015;
		}
	},
	{
		ID = "BanditsDisguisedAsDirewolves", // Only spawn from roaming beasts contract.
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditDisguisedDirewolf" }
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
