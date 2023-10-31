local parties = [
	{
		ID = "UndeadArmy",
		HardMin = 4,
		DefaultFigure = "figure_skeleton_01",
		MovementSpeedMult = 0.9,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.UndeadFrontline", 	RatioMin = 0.50, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.UndeadBackline", 	RatioMin = 0.00, RatioMax = 0.50, DeterminesFigure = true, ReqPartySize = 8},
			{ BaseID = "UnitBlock.UndeadBoss", 		RatioMin = 0.00, RatioMax = 0.10, DeterminesFigure = true, ReqPartySize = 15, StartingResourceMin = 225},
			{ BaseID = "UnitBlock.UndeadVampire", 	RatioMin = 0.00, RatioMax = 0.11, DeterminesFigure = true, ReqPartySize = 18, StartingResourceMin = 225},
		]
	},
	{
		ID = "Vampires",
		HardMin = 2,	// In vanilla this is 1
		DefaultFigure = "figure_vampire_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.UndeadVampire", 	RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true}
		]
	},
	{
		ID = "VampiresAndSkeletons",
		HardMin = 7,
		DefaultFigure = "figure_vampire_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.UndeadFrontline", 	RatioMin = 0.60, RatioMax = 1.00},		// In Vanilla only LightSkeletons spawn here
			{ BaseID = "UnitBlock.UndeadVampire", 	RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true}
		]
	},

	// SubParties,
	{	// The amount is set from outside
		ID = "SubPartySkeletonHeavy",
		UnitBlockDefs = [
			{
				ID = "Undead.SkeletonHeavyBodyguard"
			}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
