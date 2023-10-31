local parties = [
	{
		ID = "Southern",
		HardMin = 5,
		// HardMax = 40,
		DefaultFigure = "figure_southern_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.SouthernFrontline",    RatioMin = 0.50, RatioMax = 0.90, DeterminesFigure = true},			// Vanilla: doesn't care about size
			{ BaseID = "UnitBlock.SouthernBackline",     RatioMin = 0.10, RatioMax = 0.40 },				// Vanilla: doesn't care about size
			{ BaseID = "UnitBlock.SouthernRanged",       RatioMin = 0.00, RatioMax = 0.30 },		// Vanilla: doesn't care about size
			{ BaseID = "UnitBlock.Assassin",    RatioMin = 0.00, RatioMax = 0.13, ReqPartySize = 7 },		// Vanilla: Start spawning at 8+
			{ BaseID = "UnitBlock.Officer",     RatioMin = 0.00, RatioMax = 0.08, ReqPartySize = 5, DeterminesFigure = true},		// Vanilla: Start spawning at 15+
			{ BaseID = "UnitBlock.Siege",        RatioMin = 0.00, RatioMax = 0.07, ReqPartySize = 16 }		// Vanilla: Start spawning at 19+
		]
	},
	{
		ID = "CaravanSouthern",
		HardMin = 10,
		DefaultFigure = "cart_03",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.SouthernCaravanDonkey" }
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.SouthernFrontline",        RatioMin = 0.15, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.Slave",           RatioMin = 0.00, RatioMax = 0.25 },
			{ BaseID = "UnitBlock.SouthernBackline",         RatioMin = 0.10, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.Officer",         RatioMin = 0.00, RatioMax = 0.08, ReqPartySize = 14 },
			{ BaseID = "UnitBlock.SouthernCaravanDonkey",   RatioMin = 0.01, RatioMax = 0.12, ReqPartySize = 14 }   // Vanilla: Second starts spawning at 14, then 16+
		]
		// In Vanilla this party is also able to spawn just with mercenaries. But this is so rare that I chose to not try to mirror that behavior here
	},
	{
		ID = "CaravanSouthernEscort",   // For Contract Escort missions
		HardMin = 2,
		DefaultFigure = "cart_03",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.SouthernCaravanDonkey" }
		],
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.SouthernFrontline",        RatioMin = 0.35, RatioMax = 1.00 },
			// { BaseID = "UnitBlock.Slave",           RatioMin = 0.00, RatioMax = 0.25 },     // This is new. I find Slaves seen as a trade good a nice touch for player escorted southern caravans
			{ BaseID = "UnitBlock.SouthernCaravanDonkey",   RatioMin = 0.35, RatioMax = 0.50, ReqPartySize = 3 }
		]
		// In Vanilla this party is also able to spawn just with mercenaries. But this is so rare that I chose to not try to mirror that behavior here
	},
	{
		ID = "Slaves",
		HardMin = 6,
		DefaultFigure = "figure_slave_01",
		MovementSpeedMult = 0.66,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Slave",           RatioMin = 0.00, RatioMax = 1.00 }
		]
	},
	{
		ID = "NorthernSlaves",
		HardMin = 6,
		DefaultFigure = "figure_slave_01",
		MovementSpeedMult = 0.66,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.HumanSlaves",           RatioMin = 0.00, RatioMax = 1.00 }
		]
	},
	{
		ID = "Assassins",
		HardMin = 3,
		DefaultFigure = "figure_southern_01",
		MovementSpeedMult = 1.00,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Assassin",           RatioMin = 0.00, RatioMax = 1.00 }
		]
	},

	// SubParties
	{
		ID = "MortarEngineers"
		HardMin = 2,
		HardMax = 2,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.Engineer"}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}

