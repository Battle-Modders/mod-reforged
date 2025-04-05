local parties = [
	{
		ID = "GoblinRoamers",
		HardMin = 4,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,		// Pure GoblinAmbusher groups have 0.75 here in vanilla
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMax = 140 },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMax = 140 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 1.00, StartingResourceMin = 120 }
			]
		}
	},
	{	// Similar to GoblinRoamer except Scout sizes are capped in vanilla and they more mixed than Roamers. We have no cap in this implementation
		ID = "GoblinScouts",
		HardMin = 4,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,		// Parties that have no Rider have a value of 0.75 here in vanilla
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.00, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.00, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "GoblinRaiders",
		HardMin = 4,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.50 },
			{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.15, StartingResourceMin = 250 }
			]
		}
	},
	{
		ID = "GoblinDefenders",
		HardMin = 4,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.50 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35 },
				{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.15, StartingResourceMin = 250 }
			]
		}
	},
	{
		ID = "GoblinBoss",
		HardMin = 12,
		DefaultFigure = "figure_goblin_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMin = 0.35, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMin = 0.15, RatioMax = 0.50 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.35 },
				{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.01, RatioMax = 0.11 }
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
