// Vanilla: There are no parties with more than 1 Overseer and no parties with 2 Shaman without an Overseer. We allow it here for fight variety.
local parties = [
	{
		// Vanilla: Size 4-18, Cost 50-380
		ID = "GoblinRoamers", // Vanilla: 4 party types: Ambusher/Skirmisher mixed, Ambusher only, Skirmisher only, Wolfrider only; Parties become Wolfrider only eventuallly.
		Variants = ::MSU.Class.WeightedContainer([
			[1, {
				ID = "GoblinRoamers_0", // Ambushers and Skirmishers
				HardMin = 6,
				StartingResourceMax = 70, // Vanilla: Has a single party at 6 units/70 resources
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.40, RatioMax = 1.00
							function getSpawnWeight() { return base.getSpawnWeight() * 2.0; }
						},
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.25, RatioMax = 1.00 }
					]
				}
			}],
			[1, {
				ID = "GoblinRoamers_1", // Skirmishers only
				HardMin = 4,
				StartingResourceMax = 90, // Vanilla: Max cost party is 5 Skirmishers/90 resources
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 1.00 }	// Lategame GoblinRoamer only consist of Riders
					]
				}
			}],
			[1, {
				ID = "GoblinRoamers_2", // Ambushers only
				HardMin = 4,
				StartingResourceMax = 160, // Vanilla: Max cost party is 8 Ambushers/160 resources
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 0.75,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 1.00 }	// Lategame GoblinRoamer only consist of Riders
					]
				}
			}],
			[1, {
				ID = "GoblinRoamers_3", // Wolfriders only
				HardMin = 4,
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 1.00 }	// Lategame GoblinRoamer only consist of Riders
					]
				}
			}]
		])
	},
	{
		// Vanilla: Size 4-11, Cost 75-200
		ID = "GoblinScouts", // Similar to GoblinRoamer except Scout sizes are capped in vanilla and they more mixed than Roamers. We have no cap in this implementation
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "GoblinScouts_0", // Skirmisher/Ambusher
				StartingResourceMax = 200, // Vanilla: Max cost party is 4/7 Skirmishers/Ambushers at 200 resources
				HardMin = 5,
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 0.75,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 0.70, HardMin = 2 },
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 1.00
							function getSpawnWeight() { return base.getSpawnWeight() * 2.0; }
						}
					]
				}
			}],
			[1, {
				ID = "GoblinScouts_1", // Wolfrider/Ambusher: Vanilla has only one 3/3 party at 120 resources
				HardMin = 6,
				StartingResourceMax = 160, // Slightly higher max resources than vanilla because the party composition seems fun and not overpowered at this value
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.01, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.01, RatioMax = 1.00 }
					]
				}
			}],
			[4, {
				ID = "GoblinScouts_2",
				HardMin = 4,
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 1.00 }
					]
				}
			}],
		])
	},
	{
		// Vanilla: Size 5-36, Cost 55-695
		ID = "GoblinRaiders",
		Variants = ::MSU.Class.WeightedContainer([
			[1, {
				ID = "GoblinRaiders_0",
				HardMin = 7, // Smallest group Skirmisher/Ambusher 5/2
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.50 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 220 }, // First appear in Skirmisher/Ambusher/Wolfrider 4/4/4 group at 220 Resources
						{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.15, StartingResourceMin = 250 }	// One boss is guaranteed at 250+ resources
					]
				}
			}],
			[1, {
				ID = "GoblinRaiders_1", // Wolfrider/Ambusher
				StartingResourceMin = 200, // Vanilla: 7/2 with 180 resources is smallest party
				StartingResourceMax = 300, // Vanilla: 11/4 with 300 resources is largest party
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.01, RatioMax = 0.4 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.25, RatioMax = 0.85 }
					]
				}
			}],
			[1, {
				ID = "GoblinRaiders_2", // Wolfrider
				StartingResourceMin = 80, // Vanilla: 4 Wolfriders with 80 resources is smallest party
				StartingResourceMax = 360, // Vanilla: 18 Wolfriders  with 360 resources is largest party
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35 },
					]
				}
			}]
		])
	},
	{
		// Vanilla: Size 5-32, Cost 50-585
		ID = "GoblinDefenders",
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "GoblinDefenders_0",
				HardMin = 4, // Vanilla party of 4 Skirmisher
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.50 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 235 }, // First appear in full group Skirmisher/Ambusher/Wolfrider 5/5/3 at 235 resources
						{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.15, StartingResourceMin = 250 }	// One boss is guaranteed at 250+ resources
					]
				}
			}],
			[1, {
				ID = "GoblinDefenders_1", //Ambusher/Wolfrider
				StartingResourceMin = 140, // Vanilla party of 2/5 at 140 resources
				StartingResourceMax = 300, // Vanilla party of 4/11 at 300 resoures
				DefaultFigure = "figure_goblin_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.01, RatioMax = 0.4 },
						{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.25, RatioMax = 0.85 }
					]
				}
			}]
		])
	},
	{
		// 7/4/1, 9/7/1, 4/7/1, 11/3/1, Wolfriders in 6/5/5/1
		// Vanilla: Size 12-32, Cost 215-585
		ID = "GoblinBoss",
		HardMin = 12,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.60
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5; }
				},
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 325, ExclusionChance = 50 }, //Vanilla: first appears in group of 325 resources. Only appears in 50% of groups after that.
				{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.08    // One boss is always guaranteed; First 2 boss at 305 resources - always one of each. 2 shamans at 520+ resources.
					 function getSpawnWeight() { return base.getSpawnWeight() * 5.0; }
				}
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
