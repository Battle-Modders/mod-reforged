local parties = [
	{
		ID = "Cultist",
		HardMin = 4,
		DefaultFigure = "figure_civilian_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.CultistAmbush", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "Peasants",
		HardMin = 3,
		DefaultFigure = "figure_civilian_01",
		MovementSpeedMult = 0.75,
		VisibilityMult = 1.0,
		VisionMult = 0.75,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.Peasant", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "PeasantsArmed",
		HardMin = 3,
		DefaultFigure = "figure_civilian_01",
		MovementSpeedMult = 0.75,
		VisibilityMult = 1.0,
		VisionMult = 0.75,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.PeasantArmed", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "PeasantsSouthern",
		HardMin = 3,
		DefaultFigure = "figure_civilian_06",
		MovementSpeedMult = 0.75,
		VisibilityMult = 1.0,
		VisionMult = 0.75,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernPeasant", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "BountyHunters",
		HardMin = 5,
		DefaultFigure = "figure_bandit_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BountyHunter", RatioMin = 0.60, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.BountyHunterRanged", RatioMin = 0.15, RatioMax = 0.30 },
				{ BaseID = "UnitBlock.RF.Wardog", RatioMin = 0.05, RatioMax = 0.15 }
			]
		}
	},
	{
		ID = "Mercenaries",
		HardMin = 8,
		DefaultFigure = "figure_bandit_03",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.MercenaryFrontline", RatioMin = 0.60, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.MercenaryRanged", RatioMin = 0.12, RatioMax = 0.30 },
				{ BaseID = "UnitBlock.RF.MercenaryElite", RatioMin = 0.10, RatioMax = 0.25, PartySizeMin = 10 },	// Start spawning at 11+. Only exception is HedgeKnight which appears a in a group of 6 aswell
				{ BaseID = "UnitBlock.RF.Wardog", RatioMin = 0.00, RatioMax = 0.12 }
			]
		}
	},
	{
		ID = "Militia",
		HardMin = 6,
		DefaultFigure = "figure_militia_01",	// In vanilla this is either ["figure_militia_01", "figure_militia_02"]
		MovementSpeedMult = 0.9,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.MilitiaFrontline", RatioMin = 0.60, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.MilitiaRanged", RatioMin = 0.12, RatioMax = 0.35 },
				{ BaseID = "UnitBlock.RF.MilitiaCaptain", RatioMin = 0.09, RatioMax = 0.09, PartySizeMin = 12 }	// Vanilla: starts spawning in groups of 13+; Vanilla never spawns more than one
			]
		}
	},
	{
		ID = "Caravan",
		Variants = ::MSU.Class.WeightedContainer([
			[12, {
				ID = "Caravan_0",
				HardMin = 4,
				DefaultFigure = "cart_02",
				MovementSpeedMult = 0.5,
				VisibilityMult = 1.0,
				VisionMult = 0.25,
				StaticDefs = {
					Units = [
						{ BaseID = "Unit.RF.CaravanDonkey" }
					]
				},
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.CaravanDonkey", RatioMin = 0.17, RatioMax = 0.20, PartySizeMin = 6, HardMax = 2 },	// Vanilla: Second Donkey starts spawning at 7+.  Max 3 Donkies in vanilla parties.
						{ BaseID = "UnitBlock.RF.CaravanHand", RatioMin = 0.35, RatioMax = 0.80, DeterminesFigure = false },
						{ BaseID = "UnitBlock.RF.CaravanGuard", RatioMin = 0.15, RatioMax = 0.55, DeterminesFigure = false }
					]
				}
			}],
			[1, {
				ID = "Caravan_1",
				HardMin = 16,
				DefaultFigure = "cart_02",
				MovementSpeedMult = 0.5,
				VisibilityMult = 1.0,
				VisionMult = 0.25,
				StaticDefs = {
					Units = [
						{ BaseID = "Unit.RF.CaravanDonkey" }
					]
				},
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.CaravanDonkey", RatioMin = 0.17, RatioMax = 0.20, PartySizeMin = 6, HardMax = 2 },	// Vanilla: Second Donkey starts spawning at 7+. Max 3 Donkies in vanilla parties.
						{ BaseID = "UnitBlock.RF.CaravanHand", RatioMin = 0.15, RatioMax = 0.25, DeterminesFigure = false },
						{ BaseID = "UnitBlock.RF.MercenaryFrontline", RatioMin = 0.60, RatioMax = 1.00, DeterminesFigure = false },
						{ BaseID = "UnitBlock.RF.MercenaryRanged", RatioMin = 0.12, RatioMax = 0.30, DeterminesFigure = false }
					]
				}
			}]
		])
	},
	{
		ID = "CaravanEscort",	// Caravans spawned for player escort contract
		HardMin = 4,
		DefaultFigure = "cart_02",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.CaravanDonkey" },	// In vanilla an escorted caravan can also have only a single Donkey. I chose to force 2 donkey every time instead
				{ BaseID = "Unit.RF.CaravanDonkey" }
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.CaravanDonkey", RatioMin = 0.15, RatioMax = 0.35, PartySizeMin = 5, HardMax = 1 },	// Vanilla: Third donkey spawns at 6+. Max 3 Donkies in vanilla parties.
				{ BaseID = "UnitBlock.RF.CaravanHand", RatioMin = 0.50, RatioMax = 1.00, DeterminesFigure = false }
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
