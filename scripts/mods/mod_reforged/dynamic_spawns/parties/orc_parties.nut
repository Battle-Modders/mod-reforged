local parties = [
	{
		ID = "OrcRoamers",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.RF.OrcWarrior", 	RatioMin = 0.00, RatioMax = 0.09, StartingResourceMin = 150}
		]
	},
	{	// This is currently the same as OrcRoamers. I couldn't spot differences in Vanilla
		ID = "OrcScouts",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.RF.OrcWarrior", 	RatioMin = 0.00, RatioMax = 0.09, StartingResourceMin = 150}
		]
	},
	{
		ID = "OrcRaiders",
		HardMin = 5,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true, StartingResourceMax = 250},
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.00, RatioMax = 0.65, DeterminesFigure = true, StartingResourceMin = 250},	// Lategame Parties will have fewer Young in them
			{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.45, DeterminesFigure = true, StartingResourceMin = 125},
			{ BaseID = "UnitBlock.RF.OrcWarrior", 	RatioMin = 0.00, RatioMax = 0.80, DeterminesFigure = true, StartingResourceMin = 150},
			{ BaseID = "UnitBlock.RF.OrcBoss", 		RatioMin = 0.00, RatioMax = 0.08, DeterminesFigure = true, StartingResourceMin = 210}		// Vanilla never spawns more than one Boss here
		]
	},
	{
		ID = "OrcDefenders",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.15, RatioMax = 1.00},
			{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.45, StartingResourceMin = 125},
			{ BaseID = "UnitBlock.RF.OrcWarrior", 	RatioMin = 0.00, RatioMax = 0.80, StartingResourceMin = 150},
			{ BaseID = "UnitBlock.RF.OrcBoss", 		RatioMin = 0.00, RatioMax = 0.08, StartingResourceMin = 210}		// Vanilla never spawns more than one Boss here
		]
	},
	{
		ID = "OrcBoss",
		HardMin = 8,
		DefaultFigure = "figure_orc_05",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 	RatioMin = 0.15, RatioMax = 0.80},
			{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50},
			{ BaseID = "UnitBlock.RF.OrcWarrior", 	RatioMin = 0.00, RatioMax = 0.80},
			{ BaseID = "UnitBlock.RF.OrcBoss", 		RatioMin = 0.01, RatioMax = 0.05}				// Vanilla never spawns more than one Boss here
		]
	},
	{	// In Vanilla these never spawn OrcYoungLOW but here they do
		ID = "YoungOrcsOnly",
		HardMin = 4,		// In Vanilla this is 2 when spawning Berserker only
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 		DeterminesFigure = true }
		]
	},
	{	// In Vanilla these never spawn OrcYoungLOW but here they do
		ID = "YoungOrcsAndBerserkers",
		HardMin = 3,		// In Vanilla this is 2 when spawning Berserker only
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcYoung", 		DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.OrcBerserker", 	DeterminesFigure = true }
		]
	},
	{
		ID = "BerserkersOnly",
		HardMin = 2,
		DefaultFigure = "figure_orc_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.OrcBerserker" }
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}

