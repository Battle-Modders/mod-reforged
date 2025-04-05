local parties = [
	{
		ID = "Noble",
		HardMin = 8,
		DefaultFigure = "figure_noble_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.50,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.30, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.NobleBackline", RatioMax = 0.40 },
				{ BaseID = "UnitBlock.RF.NobleRanged", RatioMax = 0.30,
					function getSpawnWeight() { return base.getSpawnWeight() * 0.75; }
				},
				{ BaseID = "UnitBlock.RF.NobleElite",  RatioMax = 0.20 },
				{ BaseID = "UnitBlock.RF.NobleSupport", RatioMax = 0.2, HardMax = 2,  PartySizeMin = 9, ExclusionChance = 0.05 },
				{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMax = 0.2, HardMax = 2,  PartySizeMin = 8, ExclusionChance = 0.3 },
				{ BaseID = "UnitBlock.RF.NobleLeader", HardMax = 2, PartySizeMin = 10 },
				{ BaseID = "UnitBlock.RF.NobleFlank", RatioMax = 0.25, HardMax = 3, ExclusionChance = 0.4 }
			]
		}

		function generateIdealSize()
		{
			local startingResources = this.getStartingResources();
			if (startingResources >= 300)
			{
				return 15;
			}
			else if (startingResources >= 216)
			{
				return 13;
			}
			else
			{
				return 11;
			}
		}
	},
	{
		ID = "NobleCaravan",
		HardMin = 9,
		DefaultFigure = "cart_01",
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		UpgradeChance = 0.50,
		StaticDefs = {
			Units = [
				"Unit.RF.NobleCaravanDonkey"	// Makes it much easier to get a good ratio
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NobleFrontline", RatioMin = 0.40, RatioMax = 0.60, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleBackline", RatioMin = 0.00, RatioMax = 0.40, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleRanged", RatioMin = 0.00, RatioMax = 0.30, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleElite", RatioMin = 0.00, RatioMax = 0.20, DeterminesFigure = false },
				{ BaseID = "UnitBlock.RF.NobleOfficer", RatioMin = 0.00, RatioMax = 0.05, PartySizeMin = 10, DeterminesFigure = false, function canUpgrade() { return false; } },  // Vanilla: spawns at 12, at 15 and at 18 once respectively
				{ BaseID = "UnitBlock.RF.NobleDonkey", RatioMin = 0.01, RatioMax = 0.08, PartySizeMin = 13 }	// Vanilla: second donkey spawns at 14+
			]
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
