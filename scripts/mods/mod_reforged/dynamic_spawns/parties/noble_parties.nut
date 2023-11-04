local parties = [
	{
		ID = "Noble",
		HardMin = 10,
		DefaultFigure = "figure_noble_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.35, RatioMax = 1.00, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.NobleBackline", RatioMin = 0.01, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.NobleRanged", RatioMin = 0.01, RatioMax = 0.28 },
			{ BaseID = "UnitBlock.RF.NobleFlank", RatioMin = 0.00, RatioMax = 0.12 },
			{ BaseID = "UnitBlock.RF.NobleSupport", RatioMin = 0.01, RatioMax = 0.07, DeterminesFigure = true, ReqPartySize = 10 },    // Vanilla: Bannerman start spawning at 14
			{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMin = 0.00, RatioMax = 0.08, DeterminesFigure = true, ReqPartySize = 8 },    // Vanilla: First sergeant spawns at 9, next one 12 and then 15+; Second one spawns at 27+
			{ BaseID = "UnitBlock.RF.NobleElite", RatioMin = 0.00, RatioMax = 0.30, DeterminesFigure = true }
		]
	},
	{
		ID = "NobleCaravan",
		HardMin = 9,
		DefaultFigure = "cart_01",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.NobleCaravanDonkey" }      // Makes it much easier to get a good ratio
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.35, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.NobleBackline", RatioMin = 0.08, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.NobleRanged", RatioMin = 0.08, RatioMax = 0.28 },
			{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMin = 0.00, RatioMax = 0.08, ReqPartySize = 10 },  // Vanilla: spawns at 12, at 15 and at 18 once respectively
			{ BaseID = "UnitBlock.RF.NobleElite", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.NobleDonkey", RatioMin = 0.01, RatioMax = 0.08, ReqPartySize = 13 }   // Vanilla: second donkey spawns at 14+
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
