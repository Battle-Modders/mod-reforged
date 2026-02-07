local parties = [
	{
		// Vanilla: Size 5-32, Cost 95-635
		ID = "Noble",
		HardMin = 8,
		DefaultFigure = "figure_noble_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.40,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.30, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.NobleBackline", RatioMax = 0.40
					function getSpawnWeight() { return base.getSpawnWeight() * 1.2; }
				},
				{ BaseID = "UnitBlock.RF.NobleRanged", RatioMax = 0.30
					function getSpawnWeight() {    return base.getSpawnWeight() * (this.getParty().getStartingResources() > 180 ? 1.2 : 0.2); }
				},
				{ BaseID = "UnitBlock.RF.NobleElite",  RatioMax = 0.20
					function getSpawnWeight() { return base.getSpawnWeight() * ::Math.pow(this.getTopParty().getStartingResources() / 400, 3.0); }
				}, // vanilla greatswords spawn at 19+
				{ BaseID = "UnitBlock.RF.NobleSupport", HardMax = 1,  PartySizeMin = 9
					function getSpawnWeight() { return ::Math.pow(this.getTopParty().getStartingResources() / 225, 2.0); }
				},
				{ BaseID = "UnitBlock.RF.NobleSupport", HardMax = 1,  PartySizeMin = 15
					function getSpawnWeight() { return base.getSpawnWeight() * ::Math.pow(this.getTopParty().getStartingResources() / 850, 3.0); }
				},
				{ BaseID = "UnitBlock.RF.NobleOfficer", HardMax = 1,  PartySizeMin = 10
					function getSpawnWeight() { return base.getSpawnWeight() * ::Math.pow(this.getTopParty().getStartingResources() / 400, 2.33); }
				}, // vanilla sergeants spawn at 8+
				 { BaseID = "UnitBlock.RF.NobleOfficer", HardMax = 1,  PartySizeMin = 16
					function getSpawnWeight() { return base.getSpawnWeight() * ::Math.pow(this.getTopParty().getStartingResources() / 650, 2.0); }
				}, // vanilla sergeants spawn at 8+
				{ BaseID = "UnitBlock.RF.NobleLeader", HardMax = 2
					  function getSpawnWeight() { return base.getSpawnWeight() * ::Math.pow(this.getTopParty().getStartingResources() / 550, 3.2); }
				}, // vanilla knights spawn at 18+
				{ BaseID = "UnitBlock.RF.NobleFlank", RatioMax = 0.25, HardMax = 3, ExclusionChance = 0.4
					function getSpawnWeight() { return base.getSpawnWeight() * 0.75; }
				}
			]
		}
	},
	{
		// Vanilla: Size 7 - 21, Cost 110 - 365
		ID = "NobleCaravan",
		HardMin = 9, // Our min is higher than Vanilla to make attacking Noble Caravans for gear more difficult
		DefaultFigure = "cart_01",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		StaticDefs = {
			Units = [
				"Unit.RF.NobleCaravanDonkey" // Makes it much easier to get a good ratio
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.40, RatioMax = 0.60, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleBackline", RatioMin = 0.00, RatioMax = 0.40, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleRanged", RatioMin = 0.00, RatioMax = 0.30, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleElite", RatioMin = 0.00, RatioMax = 0.20, PartySizeMin = 16, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMin = 0.00, RatioMax = 0.05, PartySizeMin = 12, DeterminesFigure = false, function canUpgrade() { return false; }
					function getSpawnWeight() { return ::Math.pow(this.getTopParty().getStartingResources() / 350, 1.5); }
				},  // Vanilla: spawns at 12, at 15 and at 18 once respectively
				{ BaseID = "UnitBlock.RF.NobleDonkey", RatioMin = 0.01, RatioMax = 0.08, PartySizeMin = 13 }   // Vanilla: second donkey spawns at 14+
			]
		},

		function onBeforeSpawnStart()
		{
			this.UpgradeChance = this.getTopParty().getStartingResources() / 50 * 0.06;
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
