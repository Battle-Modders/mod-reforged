local parties = [
	{
		// Vanilla: Size 8-48, Cost 136-1115
		ID = "GreenskinHorde",
		Variants = ::MSU.Class.WeightedContainer([
			[3, {
				ID = "GreenskinHorde_0", // OrcYoung base
				HardMin = 9,
				DefaultFigure = "figure_orc_02",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.30, RatioMax = 0.80 },

						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5 },
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5
							 function getSpawnWeight() { return base.getSpawnWeight() * 0.50; }
						},
						{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 350, ExclusionChance = 0.5
							function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
						{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5
							 function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
						{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50, ExclusionChance = 0.5
							function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
						{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.07, StartingResourceMin = 350, ExclusionChance = 0.5 // Bosses begin appearing in earnest of 500 resources
							function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						}
					]
				}
			}],
			[3, {
				ID = "GreenskinHorde_1", // Goblin Skirmisher base
				HardMin = 9,
				DefaultFigure = "figure_orc_02",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 0.70 },
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5
							 function getSpawnWeight() { return base.getSpawnWeight() * 0.50; }
						},
						{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 350, ExclusionChance = 0.5
							function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
						{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.70, ExclusionChance = 0.5
							 function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
						{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50, ExclusionChance = 0.5 },
						{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.07, StartingResourceMin = 350, ExclusionChance = 0.5
							function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						}
					]
				}
			}],
			[1, {
				ID = "GreenskinHorde_2", // Ambusher and Warrior
				HardMin = 5,
				DefaultFigure = "figure_orc_02",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 0.70 },
						{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.70
							 function getSpawnWeight() { return base.getSpawnWeight() * 0.25; }
						},
					]
				}
			}],
			[1, {
				ID = "GreenskinHorde_3", // Ambusher and Berserker
				HardMin = 5,
				DefaultFigure = "figure_orc_02",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 0.70 },
						{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50 }
					]
				}
			}],
			[1, {
				ID = "GreenskinHorde_4", // Warrior and Wolfriders
				HardMin = 9,
				DefaultFigure = "figure_orc_02",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.50
							function getSpawnWeight() { return base.getSpawnWeight() * 0.50; }
						},
						{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.70

						},
					]
				}
			}]
		])
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
