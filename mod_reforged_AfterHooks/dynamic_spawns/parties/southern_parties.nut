local parties = [
	{
		ID = "Southern",
		HardMin = 5,
		// HardMax = 40,
		DefaultFigure = "figure_southern_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernFrontline", RatioMin = 0.50, RatioMax = 0.70 },			// Vanilla: doesn't care about size
				{ BaseID = "UnitBlock.RF.SouthernBackline", RatioMin = 0.10, RatioMax = 0.40 },				// Vanilla: doesn't care about size
				{ BaseID = "UnitBlock.RF.SouthernRanged", RatioMin = 0.00, RatioMax = 0.35 },		// Vanilla: doesn't care about size
				{ BaseID = "UnitBlock.RF.Assassin", RatioMin = 0.00, RatioMax = 0.2, PartySizeMin = 7 },		// Vanilla: Start spawning at 8+
				{ BaseID = "UnitBlock.RF.Officer", RatioMin = 0.00, RatioMax = 0.15, PartySizeMin = 5 },		// Vanilla: Start spawning at 15+
				{ BaseID = "UnitBlock.RF.Siege", RatioMin = 0.00, RatioMax = 0.13, PartySizeMin = 14 }
			]
		}
	},
	{
		ID = "CaravanSouthern",
		HardMin = 10,
		DefaultFigure = "cart_03",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.SouthernDonkey" }
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernFrontline", RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Slave", RatioMin = 0.00, RatioMax = 0.25, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.SouthernBackline", RatioMin = 0.10, RatioMax = 0.40, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Officer", RatioMin = 0.00, RatioMax = 0.08, PartySizeMin = 14, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.SouthernCaravanDonkey", RatioMin = 0.01, RatioMax = 0.12, PartySizeMin = 14 }
			]
		}
		// In Vanilla this party is also able to spawn just with mercenaries. But this is so rare that I chose to not try to mirror that behavior here
	},
	{
		ID = "CaravanSouthernEscort",	// For Contract Escort missions
		HardMin = 2,
		DefaultFigure = "cart_03",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.SouthernDonkey" }
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernFrontline", RatioMin = 0.35, RatioMax = 1.00, DeterminesFigure = false },
				// { BaseID = "UnitBlock.RF.Slave", RatioMin = 0.00, RatioMax = 0.25 },	 // This is new. I find Slaves seen as a trade good a nice touch for player escorted southern caravans
				{ BaseID = "UnitBlock.RF.SouthernCaravanDonkey", RatioMin = 0.35, RatioMax = 0.50, PartySizeMin = 3 }
			]
		}
		// In Vanilla this party is also able to spawn just with mercenaries. But this is so rare that I chose to not try to mirror that behavior here
	},
	{
		ID = "Slaves",
		HardMin = 6,
		DefaultFigure = "figure_slave_01",
		MovementSpeedMult = 0.66,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Slave", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "NorthernSlaves",
		HardMin = 6,
		DefaultFigure = "figure_slave_01",
		MovementSpeedMult = 0.66,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Slave", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Assassins",
		HardMin = 3,
		DefaultFigure = "figure_southern_01",
		MovementSpeedMult = 1.00,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Assassin", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},

	// SubParties
	{
		ID = "MortarEngineers"
		HardMin = 2,
		HardMax = 2,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Engineer"}
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
