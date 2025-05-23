local parties = [
	{
		ID = "GreenskinHorde",
		HardMin = 9,
		DefaultFigure = "figure_orc_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinRegular", RatioMin = 0.00, RatioMax = 0.50 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", RatioMin = 0.00, RatioMax = 0.50 },
				{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMin = 0.00, RatioMax = 0.13, StartingResourceMin = 350 },

				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.00, RatioMax = 0.80 },
				{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.50 },
				{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.33 },
				{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.07, StartingResourceMin = 350 }
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
