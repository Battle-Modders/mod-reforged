local parties = [
	{
		ID = "NomadRoamers",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",  // Icon for Cutthroats
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.50, RatioMax = 0.80, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.15, RatioMax = 0.50, DeterminesFigure = true }
		]
	},
	{
		ID = "NomadRaiders",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",  // Icon for Cutthroats
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.25, RatioMax = 1.00, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.00, RatioMax = 0.35, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NomadLeader", RatioMin = 0.00, RatioMax = 0.10, DeterminesFigure = true },  // They spawn as early as with 7 troops in vanilla. But 2 only start spawning in 23+
			{ BaseID = "UnitBlock.RF.NomadElite", RatioMin = 0.00, RatioMax = 0.30, DeterminesFigure = true }
		]
	},
	{
		ID = "NomadDefenders",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.25, RatioMax = 1.00, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.00, RatioMax = 0.35, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NomadLeader", RatioMin = 0.00, RatioMax = 0.10, DeterminesFigure = true },    // Vanilla: spawn at 7+
			{ BaseID = "UnitBlock.RF.NomadElite", RatioMin = 0.00, RatioMax = 0.30, DeterminesFigure = true }
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}

