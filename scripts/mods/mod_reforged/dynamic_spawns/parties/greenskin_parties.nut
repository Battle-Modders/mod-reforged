local parties = [
	{
		ID = "GreenskinHorde",
		HardMin = 9,
		DefaultFigure = "figure_orc_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.GoblinRegular", RatioMin = 0.00, RatioMax = 0.50, DeterminesFigure = true},
			{ BaseID = "UnitBlock.GoblinFlank", 			RatioMin = 0.00, RatioMax = 0.50, DeterminesFigure = true},
			{ BaseID = "UnitBlock.GoblinBoss", 			RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 350, DeterminesFigure = true},

			{ BaseID = "UnitBlock.OrcYoung", 			RatioMin = 0.00, RatioMax = 0.80, DeterminesFigure = true},
			{ BaseID = "UnitBlock.OrcWarrior", 			RatioMin = 0.00, RatioMax = 0.50, DeterminesFigure = true},
			{ BaseID = "UnitBlock.OrcBerserker", 		RatioMin = 0.00, RatioMax = 0.33, DeterminesFigure = true},
			{ BaseID = "UnitBlock.OrcBoss", 				RatioMin = 0.00, RatioMax = 0.07, StartingResourceMin = 350, DeterminesFigure = true}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
