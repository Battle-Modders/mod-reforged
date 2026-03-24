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
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.25, ExclusionChance = 0.45 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("Frontline");
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local dogs = this.getSpawnable("UnitBlock.RF.BanditDog");

			ranged.UpgradeWeightMult = 10.0;
			dogs.UpgradeWeightMult = 0.1;

			frontline.RatioMin = ::Reforged.Math.lerpClamp(res, 100, 0.0, 200, 0.2);
			ranged.RatioMin = ::Reforged.Math.lerpClamp(res, 50, 0.35, 200, 0.5);
		}

		function getUpgradeChance()
		{
			return 35 + 1.5 * this.getTotal();
		}
	},
	{
		// Vanilla: Size 6-18, Cost 61-170
		ID = "BanditScouts", // Only spawn from restore location contract
		HardMin = 6,
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
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 0.2 },
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.30 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local dogs = this.getSpawnable("UnitBlock.RF.BanditDog");
			local frontline = this.getSpawnable("Frontline");

			dogs.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 0.33, 170, 0.7);
			frontline.RatioMin = ::Reforged.Math.clamp(::Reforged.Math.lerp(res, 100, 0.7, 170, 0.5), 0.45, 0.7);
		}

		function getUpgradeChance()
		{
			return 45 + 2.0 * this.getTotal();
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
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.35 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.13, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 0.5 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("Frontline");
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local boss = this.getSpawnable("UnitBlock.RF.BanditBoss");

			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 0.6, 200, 0);
			boss.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 0.5, 600, 0);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 45 + ::Reforged.Math.lerpClamp(res, 100, 4.5, 600, 1.5) * this.getTotal();
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
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.15, PartySizeMin = 14, StartingResourceMin = 320 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local frontline = this.getSpawnable("Frontline");
			local boss = this.getSpawnable("UnitBlock.RF.BanditBoss");
			local elite = this.getSpawnable("UnitBlock.RF.BanditElite");

			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.55, 600, 0.3);
			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 0.45, 200, 0.0);

			frontline.RatioMin = ::Reforged.Math.lerpClamp(res, 200, 0.45, 600, 0.6);

			boss.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 0.6, 500, 0.0);

			elite.RatioMax = ::Reforged.Math.lerpClamp(res, 400, 0.05, 600, 0.15);
			elite.ExclusionChance = ::Reforged.Math.lerpClamp(res, 400, 0.7, 600, 0.0);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 45 + ::Reforged.Math.lerpClamp(res, 100, 4.5, 600, 1.5) * this.getTotal();
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
					RatioMin = 0.6,
					RatioMax = 1.0,
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMax = 1.0 },
							{ BaseID = "UnitBlock.RF.BanditFast", RatioMax = 0.33, ExclusionChance = 0.20 },
							{ BaseID = "UnitBlock.RF.BanditTough", RatioMax = 0.33, ExclusionChance = 0.20 }
						]
					}
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMax = 0.40 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMax = 0.2, PartySizeMin = 14, StartingResourceMin = 320 },
				{ BaseID = "UnitBlock.RF.BanditBoss", HardMin = 1, HardMax = 3, RatioMax = 0.15 }  // One boss is always guaranteed
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local elite = this.getSpawnable("UnitBlock.RF.BanditElite");

			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.40, 600, 0.3);
			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 0.15, 300, 0.0);

			elite.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 0.67, 500, 0.25);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 35 + ::Reforged.Math.lerpClamp(res, 100, 3.5, 600, 1.25) * this.getTotal();
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
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
