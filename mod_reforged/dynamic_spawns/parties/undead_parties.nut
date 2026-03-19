local parties = [
	{
		// Vanilla: Size 4-26, Cost 52-625
		ID = "UndeadArmy",
		Variants = ::MSU.Class.WeightedContainer([
			[1, {
				ID = "UndeadArmy_0",
				HardMin = 4,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.40, RatioMax = 1.0 },
						{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.00, RatioMax = 0.40 },
						{ BaseID = "UnitBlock.RF.SkeletonElite",
							function onBeforeSpawnStart()
							{
								this.RatioMax = this.getTopParty().getStartingResources() * 0.0005; // 600 resources = 0.3
							}
						},
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.20, PartySizeMin = 10, ExclusionChance = 0.85, StartingResourceMin = 200 },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMin = 0.00, RatioMax = 0.20, HardMax = 3, PartySizeMin = 6, ExclusionChance = 0.2 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMin = 0.00, RatioMax = 0.15, HardMax = 2, PartySizeMin = 9, ExclusionChance = 0.4 },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMin = 0.00, RatioMax = 0.10, HardMax = 1, PartySizeMin = 12, ExclusionChance = 0.6 },
						{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.10, HardMax = 2, PartySizeMin = 12, ExclusionChance = 0.45 }
					]
				},

				function getUpgradeChance()
				{
					return 20 + 1.25 * this.getTotal();
				}
			}],
			[1, {
				ID = "UndeadArmy_1",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 300,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, StartingResourceMin = 200, ExclusionChance = 0.66 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMax = 0.20, ExclusionChance = 0.33, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
					]
				}
			}]
		])
	},
	{
		// Vanilla: Size 1-10, Cost 40-340
		ID = "Vampires",
		HardMin = 2,
		DefaultFigure = "figure_vampire_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 10,

		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.VampireOnly", RatioMin = 0.01, RatioMax = 1.00 }
			]
		}
	},
	{
		// Vanilla: Size 7-26, Cost 108-521
		ID = "VampiresAndSkeletons",
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "VampiresAndSkeletons_0",
				HardMin = 7,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.7, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70, ExclusionChance = 0.7 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.1, RatioMax = 0.35, HardMin = 1, function getSpawnWeight() { return base.getSpawnWeight() * 20; } },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.20, HardMax = 3, PartySizeMin = 6 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, PartySizeMin = 9 },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, PartySizeMin = 12 }
					]
				},

				function getUpgradeChance()
				{
					return 10 + 2 * this.getTotal();
				}
			}],
			[1, {
				ID = "VampiresAndSkeletons_1",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 400,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.2, RatioMax = 0.4, HardMin = 1, function getSpawnWeight() { return base.getSpawnWeight() * 20; } },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, PartySizeMin = 4, ExclusionChance = 0.2 },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, PartySizeMin = 5, ExclusionChance = 0.4 }
					]
				},

				function getUpgradeChance()
				{
					return 10 + 2 * this.getTotal();
				}
			}]
		])
	},
	{
		ID = "SubPartyPrae",
		HardMin = 1,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
			]
		}
	},
	{
		ID = "SubPartyPrae2",
		HardMin = 2,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" },
				{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
			]
		}
	},
	{
		ID = "SubPartyPraeHonor",
		HardMin = 1,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" },
				{ BaseID = "Unit.RF.RF_SkeletonHeavyEliteBodyguard" }
			]
		}
	},
	{
		ID = "SubPartyHonor2",
		HardMin = 2,
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_SkeletonHeavyEliteBodyguard" },
				{ BaseID = "Unit.RF.RF_SkeletonHeavyEliteBodyguard" }
			]
		}
	},
	// {
	// 	ID = "SubPartySkeletonHeavy",
	// 	DynamicDefs = {
	// 		UnitBlocks = [
	// 			{ ID = "UnitBlock.RF_SkeletonHeavyEliteBodyguard", RatioMin = 0.01, RatioMax = 1.00 }
	// 		]
	// 	}
	// }
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
