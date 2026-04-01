local parties = [
	{
		// Vanilla: Size 8-48, Cost 136-1115
		ID = "GreenskinHorde",
		HardMin = 8,
		DefaultFigure = "figure_orc_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			Parties = [
				{
					ID = "Orcs",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.OrcYoung" },
							{ BaseID = "UnitBlock.RF.OrcBerserker", StartingResourceMin = 200, SpawnWeightMult = 0.3 },
							{ BaseID = "UnitBlock.RF.OrcWarrior", StartingResourceMin = 230 },
							{ BaseID = "UnitBlock.RF.OrcBoss", HardMax = 1, StartingResourceMin = 480, PartySizeMin = 14 } // vanilla StartingResourceMin = 480
						]
					}
				},
				{
					ID = "Goblins",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.GoblinFrontline" },
							{ BaseID = "UnitBlock.RF.GoblinRanged" },
							{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 160 },
							{ BaseID = "UnitBlock.RF.GoblinBoss", HardMax = 1, StartingResourceMin = 390, PartySizeMin = 21 } // vanilla StartingResourceMin = 389
							{ BaseID = "UnitBlock.RF.GoblinSupport", HardMax = 3, StartingResourceMin = 495, PartySizeMin = 17, SpawnWeightMult = 0.2 } // vanilla StartingResourceMin = 495
						]
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local orcs = this.getSpawnable("Orcs");
			local goblins = this.getSpawnable("Goblins");
			local orcBoss = this.getSpawnable("UnitBlock.RF.OrcBoss");
			local goblinBoss = this.getSpawnable("UnitBlock.RF.GoblinBoss");

			// Choose either orcs or goblins as preferred baseline to have higher ratio of
			local chosen;
			if (::Math.rand(1, 2) == 1)
			{
				chosen = orcs;
				goblinBoss.ExclusionChance = 50; // Likely to exclude GoblinBoss when Orc-heavy party
			}
			else
			{
				chosen = goblins;
				orcBoss.ExclusionChance = 50; // Likely to exclude OrcBoss when Goblin-heavy party
			}

			chosen.RatioMin = 0.6;

			// More likely to spawn bosses at higher resources
			orcBoss.SpawnWeightMult = ::Reforged.Math.lerpClamp(res, 150, 0.1, 1100, 0.3);
			goblinBoss.SpawnWeightMult = ::Reforged.Math.lerpClamp(res, 150, 0.1, 1100, 0.3);

			// 30% chance to have Goblin Wolfrider "twist" i.e. high occurrence of them
			if (::Math.rand(1, 100) > 70)
			{
				this.getSpawnable("UnitBlock.RF.GoblinFlank").SpawnWeightMult = 5.0;
			}

			// 30% chance to have Orc Warrior "twist" i.e. high occurrence of them
			if (::Math.rand(1, 100) > 70)
			{
				this.getSpawnable("UnitBlock.RF.OrcWarrior").SpawnWeightMult = 5.0;
			}

			// Fewer Young at higher resources
			this.getSpawnable("UnitBlock.RF.OrcYoung").SpawnWeightMult = ::Reforged.Math.lerpClamp(res, 150, 1.0, 1100, 0.4);
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
