local parties = [
	{
		// Vanilla: Size 4-28, Cost 48-900
		ID = "Barbarians",
		HardMin = 4,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianFrontline", RatioMin = 0.60, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.BarbarianSupport", HardMax = 2, RatioMin = 0.00, RatioMax = 0.15, PartySizeMin = 10 },
				{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMin = 0.00, RatioMax = 0.4, PartySizeMin = 5, ExclusionChance = 0.7 },
				{ BaseID = "UnitBlock.RF.BarbarianBeastmaster", HardMax = 3, RatioMin = 0.00, RatioMax = 0.2, PartySizeMin = 5, ExclusionChance = 0.77 }
			]
		},

		function getUpgradeChance()
		{
			return 30 + 2.5 * this.getTotal();
		}
	},
	{
		// Vanilla: Size 5-19, Cost 56-214
		ID = "BarbarianHunters",
		HardMin = 5,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianHunterFrontline", RatioMin = 0.60, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMin = 0.25, RatioMax = 0.40 }
			]
		},

		function getUpgradeChance()
		{
			return 30 + 2.5 * this.getTotal();
		}
	},
	{
		// Is never spawned on its own, but rather is used by vanilla to add units (in vanilla only a Barbarian King)
		// to the party spawned by the Barbarian King Contract.
		ID = "BarbarianKing",
		DefaultFigure = "figure_wildman_04",
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.BarbarianChosen" }
			]
		}
	},

	// SubParties
	{
		ID = "OneUnhold",
		HardMin = 1,
		HardMax = 1,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnhold" }
			]
		}
	},
	{
		ID = "TwoUnhold",
		HardMin = 2,
		HardMax = 2,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnhold" }
			]
		}
	},
	{
		ID = "OneFrostUnhold",
		HardMin = 1,
		HardMax = 1,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost" }
			]
		}
	},
	{
		ID = "TwoFrostUnhold",
		HardMin = 2,
		HardMax = 2,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost" }
			]
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
