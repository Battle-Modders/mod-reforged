local parties = [
	{
		// Vanilla: Size 5-39, Cost 95-770
		ID = "Southern",
		HardMin = 5,
		// HardMax = 40,
		DefaultFigure = "figure_southern_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernFrontline", RatioMin = 0.40, RatioMax = 0.8
					function getSpawnWeight() { return base.getSpawnWeight() * 0.80; }

				}, // Vanilla: doesn't care about size
				{ BaseID = "UnitBlock.RF.SouthernBackline", RatioMin = 0.00, RatioMax = 0.40 // Vanilla: doesn't care about size
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() >= 250 ? 0.70 : 0.30); }
				},
				{ BaseID = "UnitBlock.RF.SouthernRanged", RatioMin = 0.00, RatioMax = 0.30 // Vanilla: doesn't care about size
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() >= 225 ? 0.70 : 0.2); }
				},
				{ BaseID = "UnitBlock.RF.Assassin", RatioMin = 0.00, RatioMax = 0.35, PartySizeMin = 7
					function getSpawnWeight() { return base.getSpawnWeight() * 0.15; }
				}, 	// Vanilla: Start spawning at 8+
				{ BaseID = "UnitBlock.RF.Officer", RatioMin = 0.00, RatioMax = 0.15, PartySizeMin = 5
					function getSpawnWeight() { return base.getSpawnWeight() * 0.7; }
					function onBeforeSpawnStart() { this.HardMax = ::Math.floor(this.getTopParty().getStartingResources() / 175); }
				},	// Vanilla: Start spawning at 15+. 2 officers in paty with 330 resources. 3 officers 525.
				{ BaseID = "UnitBlock.RF.Siege", RatioMin = 0.00, RatioMax = 0.13  // Vanilla: Start spawning at 19+. 2 Mortars at 430+ resources and 24 party size.
					function getSpawnWeight() { return base.getSpawnWeight() * 0.50; }
					function onBeforeSpawnStart() { this.HardMax = ::Math.floor(this.getTopParty().getStartingResources() / 220); }
				},
				{ BaseID = "UnitBlock.RF.Slave", RatioMin = 0.30, RatioMax = 0.70, StartingResourceMin = 300, ExclusionChance = 90,  // Vanilla: Start spawning in a party of 304 resources. Once they start spawning, they are only in 3 of about 60 parties.
				function getSpawnWeight() { return base.getSpawnWeight() * 5.0; }
				}
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
				{ BaseID = "Unit.RF.SouthernDonkey" } // Makes it much easier to get a good ratio
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.SouthernFrontline", RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Slave", RatioMin = 0.10, RatioMax = 0.40, ExclusionChance = 75, DeterminesFigure = false
					function getSpawnWeight() { return base.getSpawnWeight() * 3.0; }
				}, // Vanilla: Slaves are in about 1/4 parties
				{ BaseID = "UnitBlock.RF.SouthernBackline", RatioMin = 0.10, RatioMax = 0.40, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.Officer", RatioMin = 0.00, RatioMax = 0.08, PartySizeMin = 14, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.SouthernCaravanDonkey", RatioMin = 0.01, RatioMax = 0.12, PartySizeMin = 14 }    // Vanilla: Second starts spawning at 14, then 16+
			]
		}
		// In Vanilla this party is also able to spawn just with mercenaries. But this is so rare that I chose to not try to mirror that behavior here
	},
	{
		ID = "CaravanSouthernEscort",    // For Contract Escort missions
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
				// { BaseID = "UnitBlock.RF.Slave", RatioMin = 0.00, RatioMax = 0.25 },     // This is new. I find Slaves seen as a trade good a nice touch for player escorted southern caravans
				{ BaseID = "UnitBlock.RF.SouthernCaravanDonkey", RatioMin = 0.35, RatioMax = 0.50, PartySizeMin = 3, HardMax = 2 } // Vanilla: Max donkeys is 3
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
				{ BaseID = "UnitBlock.RF.Engineer" }
			]
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
