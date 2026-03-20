local parties = [
	{
		// Vanilla: Size 5-32, Cost 95-635
		ID = "Noble",
		HardMin = 8,
		DefaultFigure = "figure_noble_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.30, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.NobleBackline", RatioMax = 0.40
					//  function getSpawnWeight() { return base.getSpawnWeight() * 1.4; }
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() > 350 ? 1.8 : 1.4); }
				},
				{ BaseID = "UnitBlock.RF.NobleRanged", RatioMax = 0.30
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 330)
						{
							return base.getSpawnWeight() * 2.0;
						}
						else (this.getTopParty().getStartingResources() >= 280)
						{
							return base.getSpawnWeight() * 1.2;
						}
					}
				},
				{ BaseID = "UnitBlock.RF.NobleElite",  RatioMax = 0.20
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 450)
						{
							return base.getSpawnWeight() * 2.0;
						}
						else if (this.getTopParty().getStartingResources() >= 370)
						{
							return base.getSpawnWeight() * 1.0;
						}
						else
						{
							return base.getSpawnWeight() * 0.33;
						}
					}
				}, // vanilla greatswords spawn at 19+
				{ BaseID = "UnitBlock.RF.NobleSupport", RatioMax = 0.09
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() > 250 ? 3 : 0.5); }
				},
				{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMax = 0.10
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() > 500)
						{
							return base.getSpawnWeight() * 3.0;
						}
						else if (this.getTopParty().getStartingResources() > 400)
						{
							return base.getSpawnWeight() * 2.0;
						}
						else if (this.getTopParty().getStartingResources() > 250)
						{
							return base.getSpawnWeight() * 0.60;
						}
						else
						{
							return base.getSpawnWeight() * 0.20;
						}
					}
				}, // vanilla sergeants spawn at 8+
				{ BaseID = "UnitBlock.RF.NobleLeader", RatioMax = 0.08
					 function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() > 450 ? 2 : 0.30); }
				}, // vanilla knights spawn at 18+
				{ BaseID = "UnitBlock.RF.NobleFlank", RatioMax = 0.25, HardMax = 3, ExclusionChance = 0.4
					function getSpawnWeight() { return base.getSpawnWeight() * 0.75; }
				}
			]
		},

		function getUpgradeChance()
		{
			if (this.getTopParty().getStartingResources() >= 700)
			{
				return 80;
			}
			else
			{
				return 50;
			}
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
				{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMin = 0.00, RatioMax = 0.05, PartySizeMin = 12, HardMax = 1, DeterminesFigure = false
					function getSpawnWeight() { return ::Math.pow(this.getTopParty().getStartingResources() / 350, 1.5); }
				},  // Vanilla: spawns at 12, at 15 and at 18 once respectively
				{ BaseID = "UnitBlock.RF.NobleDonkey", RatioMin = 0.01, RatioMax = 0.08, PartySizeMin = 13 }   // Vanilla: second donkey spawns at 14+
			]
		},

		function getUpgradeChance()
		{
			if (this.getTopParty().getStartingResources() >= 500)
			{
				return 80;
			}
			else
			{
				return 50;
			}
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
