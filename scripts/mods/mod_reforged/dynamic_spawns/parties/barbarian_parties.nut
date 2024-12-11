local parties = [
	{
		ID = "Barbarians",
		HardMin = 6,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianFrontline", RatioMin = 0.60, RatioMax = 1.00, DeterminesFigure = true },	// Vanilla: doesn't care about size
			{ BaseID = "UnitBlock.RF.BarbarianSupport", RatioMin = 0.00, RatioMax = 0.07, ReqPartySize = 10 },			// Vanilla: Start spawning in armies of 15+; At 24+ a second drummer spawns
			{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMin = 0.00, RatioMax = 0.15, ReqPartySize = 5 },		// Vanilla: Start spawning in armies of 6+
			{ BaseID = "UnitBlock.RF.BarbarianBeastmaster", RatioMin = 0.00, RatioMax = 0.10, ReqPartySize = 5 }		// Vanilla: Start spawning in armies of 7+ (singular case) but more like 9+
		]

		function generateIdealSize()
		{
			local startingResources = this.getSpawnProcess().getStartingResources();

			if (startingResources >= 550)
			{
				return 12;
			}
			else if (startingResources >= 450)
			{
				return 10;
			}
			else if (startingResources >= 216)
			{
				return 8;
			}
			else
			{
				return 8;
			}
		}
	},
	{
		ID = "BarbarianHunters",
		HardMin = 5,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianHunterFrontline", RatioMin = 0.60, RatioMax = 1.0, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMin = 0.20, RatioMax = 0.45 }
		]

		function generateIdealSize()
		{
			local startingResources = this.getSpawnProcess().getStartingResources();
			if (startingResources >= 216)
			{
				return 12;
			}
			else if (startingResources >= 164)
			{
				return 10;
			}
			else
			{
				return 8;
			}
		}
	},
	{
		ID = "BarbarianKing",
		DefaultFigure = "figure_wildman_06",
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.BarbarianChosen" },
			{ BaseID = "Unit.RF.BarbarianMarauder" }  // always spawn with one reaver to make early game contracts more balanced
		]
	},

	// SubParties
	{
		ID = "OneUnhold",
		HardMin = 1,
		HardMax = 1,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianUnhold"}
		]
	},
	{
		ID = "TwoUnhold",
		HardMin = 2,
		HardMax = 2,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianUnhold"}
		]
	},
	{
		ID = "OneFrostUnhold",
		HardMin = 1,
		HardMax = 1,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost"}
		]
	},
	{
		ID = "TwoFrostUnhold",
		HardMin = 2,
		HardMax = 2,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost"}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
