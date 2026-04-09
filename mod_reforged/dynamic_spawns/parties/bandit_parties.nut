local parties = [
	{
		ID = "RF_BanditFrontline",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditBalanced" },
				{ BaseID = "UnitBlock.RF.BanditFast", RatioMax = 0.33, ExclusionChance = 20 },
				{ BaseID = "UnitBlock.RF.BanditTough", RatioMax = 0.33, ExclusionChance = 20 }
			]
		}
	},
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
				{ BaseID = "RF_BanditFrontline", RatioMin = 0.3, RatioMax = 0.6 }
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.35, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.25, ExclusionChance = 45 }
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
		DynamicDefs = {
			Parties = [
				{ BaseID = "RF_BanditFrontline", RatioMin = 0.4, RatioMax = 1.0 }
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 20 },
				{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.30 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local dogs = this.getSpawnable("UnitBlock.RF.BanditDog");
			local frontline = this.getSpawnable("Frontline");

			dogs.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 33, 170, 70);
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
		DynamicDefs = {
			Parties = [
				{ BaseID = "RF_BanditFrontline", RatioMin = 0.5, RatioMax = 1.0 }
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.35 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.13, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 50 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("Frontline");
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local boss = this.getSpawnable("UnitBlock.RF.BanditBoss");

			this.getSpawnable("Unit.RF.BanditThug").StartingResourceMax = 250;
			this.getSpawnable("Unit.RF.RF_BanditThugTough").StartingResourceMax = 250;

			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 60, 200, 0);
			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.5, 600, 0.25);
			ranged.RatioMin = ::Reforged.Math.lerpClamp(res, 200, 0.0, 300, 0.2);

			boss.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 95, 500, 0);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 20 + ::Reforged.Math.lerpClamp(res, 100, 4.5, 600, 1.5) * this.getTotal();
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
		DynamicDefs = {
			Parties = [
				{ BaseID = "RF_BanditFrontline", RatioMin = 0.45, RatioMax = 1.0 }
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged" },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMax = 0.15, PartySizeMin = 14, StartingResourceMin = 320, ExclusionChance = 60 },
				{ BaseID = "UnitBlock.RF.BanditBoss", RatioMax = 0.14, HardMax = 3, PartySizeMin = 7, StartingResourceMin = 140 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local frontline = this.getSpawnable("Frontline");
			local boss = this.getSpawnable("UnitBlock.RF.BanditBoss");
			local elite = this.getSpawnable("UnitBlock.RF.BanditElite");

			this.getSpawnable("Unit.RF.BanditThug").StartingResourceMax = 320;
			this.getSpawnable("Unit.RF.RF_BanditThugTough").StartingResourceMax = 320;

			ranged.RatioMin = ::Reforged.Math.lerpClamp(res, 200, 0.0, 300, 0.2);
			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.55, 600, 0.3);
			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 100, 45, 200, 0);

			frontline.RatioMin = ::Reforged.Math.lerpClamp(res, 200, 0.45, 400, 0.6);

			boss.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 66, 400, 0);

			elite.RatioMax = ::Reforged.Math.lerpClamp(res, 400, 0.05, 600, 0.15);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 20 + ::Reforged.Math.lerpClamp(res, 100, 4.5, 600, 1.5) * this.getTotal();
		}
	},
	{
		// Vanilla: Size 7-28, Cost 145-585
		// Vanilla has 1 party at 320 resources without a BanditLeader. Seems like an oversight.
		ID = "BanditBoss",
		HardMin = 7,
		DefaultFigure = "figure_bandit_04",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			Parties = [
				{ BaseID = "RF_BanditFrontline", RatioMin = 0.6, RatioMax = 1.0 }
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BanditRanged", RatioMax = 0.40 },
				{ BaseID = "UnitBlock.RF.BanditElite", RatioMax = 0.2, PartySizeMin = 14, StartingResourceMin = 320 },
				{ BaseID = "UnitBlock.RF.BanditBoss", HardMin = 1, HardMax = 3 }  // One boss is always guaranteed
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local ranged = this.getSpawnable("UnitBlock.RF.BanditRanged");
			local elite = this.getSpawnable("UnitBlock.RF.BanditElite");
			local boss = this.getSpawnable("UnitBlock.RF.BanditBoss");

			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.40, 600, 0.3);
			ranged.ExclusionChance = ::Reforged.Math.lerpClamp(res, 200, 15, 300, 0);

			elite.ExclusionChance = ::Reforged.Math.lerpClamp(res, 300, 60, 500, 25);

			boss.RatioMax = ::MSU.Class.WeightedContainer([
				[60, 0.05],
				[20, 0.1],
				[20, 0.15]
			]);
		}

		function getUpgradeChance()
		{
			local res = this.getTopParty().getStartingResources();
			return 30 + ::Reforged.Math.lerpClamp(res, 100, 3.5, 600, 1.25) * this.getTotal();
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
