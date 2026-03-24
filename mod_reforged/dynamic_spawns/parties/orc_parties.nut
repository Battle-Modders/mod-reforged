local parties = [
	{
		// Vanilla: Size 4-14, Cost 64-260 Orc Young Orc Berserkers. Spawns Composition: Young/Young & Berserkers 6/6.
		ID = "OrcRoamers", // Send Orc Roamers action
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.55, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.OrcBerserker", StartingResourceMin = 75, RatioMax = 0.45, PartySizeMin = 5 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local berserkers = this.getSpawnable("UnitBlock.RF.OrcBerserker");
			if (res < 150)
			{
				// Berserkers are more likely to be excluded at lower resources
				berserkers.ExclusionChance = 37.5 / res;
			}
			else
			{
				// Berserkers are guaranteed above 150 resources party
				berserkers.ExclusionChance = 0;
				berserkers.RatioMin = 75.0 / res;
			}
		}
	},
	{	// Vanilla: Size: 4-12, Cost 52-176. Spawns Composition: Young/Young & Warrior 13/2. Only ever 1 Orc Warrior.
		ID = "OrcScouts",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.80, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.OrcWarrior", ExclusionChance = 0.66, StartingResourceMin = 95 // Vanilla only has OrcWarriorLOW that starts at 94 resources
					function getSpawnWeight() { return base.getSpawnWeight() * 0.1; }
				}
			]
		}
	},
	{
		// Vanilla: Size: 5-29, Cost 77-822.
		// Young (14, 78-272)
		// Young, Warrior (15, 94-360)
		// Young, Berserkers (7, 77-472)
		// Young, Warrior, Berserker (5, 289-797)
		// Young, Warrior, Warlord (1, 602-602)
		// Young, Warrior, Berserker, Warlord (12, 495-822)
		// Warrior, Berserker, Warlord (2, 405-445)
		ID = "OrcRaiders",
		HardMin = 5,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung" },
				{ BaseID = "UnitBlock.RF.OrcBoss", HardMax = 1, StartingResourceMin = 400 },
				{ BaseID = "UnitBlock.RF.OrcBerserker", StartingResourceMin = 75 },
				{ BaseID = "UnitBlock.RF.OrcWarrior", StartingResourceMin = 100 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local young = this.getSpawnable("UnitBlock.RF.OrcYoung");
			local warrior = this.getSpawnable("UnitBlock.RF.OrcWarrior");
			local berserker = this.getSpawnable("UnitBlock.RF.OrcBerserker");
			local boss = this.getSpawnable("UnitBlock.RF.OrcBoss");

			// Vanilla doesn't have the Warlord in 3 out of 18 spawns (i.e. 17% exclusion) above his StartingResourceMin.
			if (::Math.rand(1, 100) <= 17)
			{
				boss.HardMax = 0;
			}
			else if (boss.isValid())
			{
				boss.HardMin = 1;
			}

			young.RatioMin = ::Reforged.Math.lerpClamp(res, 100, 0.5, 820, 0.2);
			berserker.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.6, 720, 0.33);

			// Chance to exclude Berserker.
			if (::Math.rand(1, 100) < ::Reforged.Math.lerpClamp(res, 100, 75, 300, 0))
			{
				berserker.HardMax = 0;
			}

			// Warlord is present
			if (boss.HardMin == 1)
			{
				warrior.HardMin = 2; // Have at least 2 warriors when Warlord is present
			}
			// Warlord is absent
			else
			{
				// Chance to exclude Warrior.
				if (::Math.rand(1, 100) <= ::Reforged.Math.lerpClamp(res, 100, 55, 400, 0))
				{
					warrior.HardMax = 0;
				}
				else
				{
					warrior.SpawnWeightMult = 0.5;
				}
			}

			// Can only reduce RatioMax of OrcYoung when Warrior is valid. Otherwise we won't be left
			// with any unit block that can spawn as Berserker has a RatioMax and Boss has a HardMax.
			if (warrior.isValid())
			{
				// Fewer Young at higher resources
				young.RatioMax = ::Reforged.Math.lerpClamp(res, 100, 1.0, 820, 0.3);
			}
		}
	},
	{
		// Vanilla: Size 4-23, Cost 52-720, Variants 40. Orc Camp location and Defend Orcs Action
		// Young (12) / Young, Berserker (8) / Young, Warrior (4) / Young, Warrior, Berserker (15) / Warrior (1)
		ID = "OrcDefenders",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung" },
				{ BaseID = "UnitBlock.RF.OrcBoss", HardMax = 1, StartingResourceMin = 210 }
			],
			Parties = [
				{
					ID = "BerserkersAndWarriors",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.OrcBerserker", StartingResourceMin = 75 },
							{ BaseID = "UnitBlock.RF.OrcWarrior", StartingResourceMin = 100 }
						]
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local young = this.getSpawnable("UnitBlock.RF.OrcYoung");
			local berserker = this.getSpawnable("UnitBlock.RF.OrcBerserker");
			local warrior = this.getSpawnable("UnitBlock.RF.OrcWarrior");
			local boss = this.getSpawnable("UnitBlock.RF.OrcBoss");

			// Vanilla guarantees a Warlord above 400 resources
			if (::Math.rand(1, 100) <= ::Reforged.Math.lerpClamp(res, 300, 75, 400, 0)) // Drops from 75 at 300 to 0 at 400)
			{
				boss.HardMax = 0;
			}
			else
			{
				boss.HardMin = 1;
			}

			// Berserkers and Warriors are always present above 300 resources.
			if (::Math.rand(1, 100) <= ::Reforged.Math.lerpClamp(res, 200, 56, 300, 0))
			{
				berserker.HardMax = 0;
			}

			// Warlord is present
			if (boss.HardMin == 1)
			{
				warrior.HardMin = 2; // Have at least 2 warriors when Warlord is present
			}
			// Warlord is absent
			else if (::Math.rand(1, 100) <= ::Reforged.Math.lerpClamp(res, 200, 0.6,300, 0))
			{
				warrior.HardMax = 0;
			}

			if (berserker.isValid() || warrior.isValid())
			{
				young.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 1.0, 720, 0.25); // Drops from 1.0 at 200 to 0.25 at 650
				young.RatioMin = ::Reforged.Math.clamp(::Reforged.Math.lerp(res, 200, 0.5, 720, 0.25), 0.25, 1.0); // Drops from 0.5 at 200 to 0.25 at 720
			}

			if (warrior.isValid())
			{
				// Higher resources lead to a greater ratio of Warriors compared to Berserkers.
				// Ratio of Berserker/Warrior drops from 0.6 at 200 to 0.33 at 720
				berserker.RatioMax = ::Reforged.Math.lerpClamp(res, 720, 0.33, 200, 0.6);
			}
		}
	},
	{
		// Vanilla: Size 7-32, Cost 164-798. Variants 25. Orc Settlement Location
		// Young, Berserker (3) / Young, Warrior (4) / Young, Warrior, Berserker (18)
		ID = "OrcBoss",
		HardMin = 8,
		DefaultFigure = "figure_orc_05",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung" },
				{ BaseID = "UnitBlock.RF.OrcBoss", HardMin = 1, HardMax = 1 } // Vanilla always has a Warlord present in this party
			],
			Parties = [
				{
					ID = "BerserkersAndWarriors",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.OrcBerserker" },
							{ BaseID = "UnitBlock.RF.OrcWarrior", StartingResourceMin = 210 }
						]
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local young = this.getSpawnable("UnitBlock.RF.OrcYoung");
			local berserker = this.getSpawnable("UnitBlock.RF.OrcBerserker");
			local warrior = this.getSpawnable("UnitBlock.RF.OrcWarrior");

			// Fewer Young at higher resources
			young.RatioMax = ::Reforged.Math.lerpClamp(res, 150, 0.7, 800, 0.5); // Drops from 0.7 at 150 to 0.5 at 800
			young.RatioMin = ::Reforged.Math.lerpClamp(res, 150, 0.5, 800, 0.25); // Drops from 0.5 at 150 to 0.25 at 800

			if (res < 315)
			{
				// 20% chance that either Berserkers or Warriors are absent.
				// If true then 60% of the time it is Berserkers that are absent.
				if (::Math.rand(1, 100) > 20)
				{
					if (::Math.rand(1, 100) <= 60)
					{
						berserker.HardMax = 0;
					}
					else
					{
						warrior.HardMax = 0;
					}
				}
			}
			// Tweak the ratio of Berserkers to Warriors at higher resources.
			else
			{
				// Generally we have fewer Berserkers than Warriors.
				berserker.RatioMax = ::Reforged.Math.clamp(::Reforged.Math.multilerp(res, [
					[300, 0.25],
					[600, 0.5],
					[800, ::MSU.Math.randf(0.25, 1.0)]
				]), 0.25, 1.0);

				// A small chance for more Berserkers at higher resources. Vanilla has 1 such party out of 16.
				if (::Math.rand(1, 100) <= 10)
				{
					berserker.RatioMin = berserker.RatioMax;
				}
			}
		}
	},
	{
		// Vanilla: Size 4-18, Cost 64-288, Variants 15.
		ID = "YoungOrcsOnly", // Orc Hideout Location
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				"UnitBlock.RF.OrcYoung"
			]
		}
	},
	{
		// Vanilla: Size 2-18, Cost 5-288, Variants 25.
		// Young (15) / Berserker (7) / Young, Berserker (3)
		ID = "YoungOrcsAndBerserkers", // Orc Ruins Location
		HardMin = 3, // In Vanilla this is 2 when spawning Berserker only
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung" },
				{ BaseID = "UnitBlock.RF.OrcBerserker" }
			]
		},

		function onBeforeSpawnStart()
		{
			local young = this.getSpawnable("UnitBlock.RF.OrcYoung");
			local berserker = this.getSpawnable("UnitBlock.RF.OrcBerserker");

			// 12% chance for Young + Berserkers to be present.
			// When one of them is absent then 30% of those times it is Young that are absent.
			if (::Math.rand(1, 100) > 12)
			{
				if (::Math.rand(1, 100) <= 30)
				{
					young.HardMax = 0;
				}
				else
				{
					berserker.HardMax = 0;
				}
			}
			else
			{
				berserker.RatioMax = ::MSU.Math.randf(0.25, 0.5);
			}
		}
	},
	{
		// Vanilla: Size 2-11, Cost 50-248, Variants 18
		// Berserkers (8) / Berserkers, Young (10)
		// Orc Cave location and Confront Warlord Contract
		ID = "BerserkersOnly",
		HardMin = 2,
		DefaultFigure = "figure_orc_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", ExclusionChance = 0.4, SpawnWeightMult = 0.18 },
				{ BaseID = "UnitBlock.RF.OrcBerserker", HardMin = 2, RatioMin = 0.6, RatioMax = 1.0 }
			]
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
