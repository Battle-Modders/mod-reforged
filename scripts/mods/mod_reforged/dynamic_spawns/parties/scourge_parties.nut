local parties = [
	{
		ID = "UndeadScourge",
		HardMin = 8,
		DefaultFigure = "figure_skeleton_01",
		MovementSpeedMult = 0.9,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.ZombieFrontline", 	RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.Ghost", 		RatioMin = 0.00, RatioMax = 0.12, ReqPartySize = 18},
			{ BaseID = "UnitBlock.Ghouls", 		RatioMin = 0.00, RatioMax = 0.20, ReqPartySize = 20},	// Vanilla does not spawn T3 Ghouls. We allow it here
			{ BaseID = "UnitBlock.UndeadFrontline", 	RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.UndeadBackline", 	RatioMin = 0.09, RatioMax = 0.35, DeterminesFigure = true},
			{ BaseID = "UnitBlock.ScourgeBoss", 		RatioMin = 0.00, RatioMax = 0.12, DeterminesFigure = true, ReqPartySize = 17, StartingResourceMin = 350},
			{ BaseID = "UnitBlock.Vampire", 	RatioMin = 0.00, RatioMax = 0.11, DeterminesFigure = true, ReqPartySize = 18},
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
