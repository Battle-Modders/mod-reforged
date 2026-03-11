local parties = [
	{
		// Vanilla: Size 4-26, Cost 52-625
		ID = "UndeadArmy",
		Variants = ::MSU.Class.WeightedContainer([
			[3, {
				ID = "UndeadArmy_0",
				HardMin = 4,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0

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
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.30, PartySizeMin = 10, ExclusionChance = 0.75, StartingResourceMin = 200 },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMin = 0.00, RatioMax = 0.20, HardMax = 3, StartingResourceMin = 180, PartySizeMin = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMin = 0.00, RatioMax = 0.15, HardMax = 2, StartingResourceMin = 250, PartySizeMin = 9, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMin = 0.00, RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, PartySizeMin = 12, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.10, HardMax = 2, PartySizeMin = 12, ExclusionChance = 0.45 }
					]
				},
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
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMax = 0.20, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
					]
				}
			}],
			[1, {
				ID = "UndeadArmy_2",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.0 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, StartingResourceMin = 220 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.20, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
					]
				}
			}],
			[1, {
				ID = "UndeadArmy_3",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
					]
				}
			}]
		])
	},
	{
		ID = "Vampires",
		HardMin = 2,
		DefaultFigure = "figure_vampire_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.1,

		function generateIdealSize()
		{
			return 4;
		}

		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.VampireOnly", RatioMin = 0.01, RatioMax = 1.00 }
			]
		}
	},
	{
		ID = "VampiresAndSkeletons",
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "VampiresAndSkeletons_0",
				HardMin = 7,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0

				function generateIdealSize()
				{
					local startingResources = this.getTopParty().getStartingResources();
					if (startingResources >= 400)
					{
						return 11;
					}
					else if (startingResources >= 350)
					{
						return 10;
					}
					else if (startingResources >= 300)
					{
						return 9;
					}
					else
					{
						return 8;
					}
				}

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, HardMin = 3, function getSpawnWeight(){ return base.getSpawnWeight() * 0.5 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.20, StartingResourceMin = 180, HardMax = 3, PartySizeMin = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, StartingResourceMin = 250, HardMax = 2, PartySizeMin = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.15 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, StartingResourceMin = 300, HardMax = 1, PartySizeMin = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
					]
				}
			}],
			[1, {
				ID = "VampiresAndSkeletons_1",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 300,
				UpgradeChance = 0.5,

				function generateIdealSize()
				{
					return 9;
				}

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.50, HardMin = 3, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, PartySizeMin = 4, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, PartySizeMin = 5, function getSpawnWeight(){ return base.getSpawnWeight() * 0.15 } }
					]
				}
			}],
			[1, {
				ID = "VampiresAndSkeletons_2",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				function generateIdealSize()
				{
					local startingResources = this.getTopParty().getStartingResources();
					if (startingResources >= 400)
					{
						return 10;
					}
					else if (startingResources >= 350)
					{
						return 9;
					}
					else
					{
						return 8;
					}
				}

				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 0.70, function getUpgradeWeight(){ return base.getUpgradeWeight() * 1.5 } },
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70, function getSpawnWeight(){ return base.getSpawnWeight() * 0.75 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.2 } },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.70, HardMin = 3, function getSpawnWeight(){ return base.getSpawnWeight() * 0.75 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.1 } },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.20, HardMax = 3, StartingResourceMin = 180, function getSpawnWeight(){ return base.getSpawnWeight() * 0.3 } },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, function getSpawnWeight(){ return base.getSpawnWeight() * 0.3 } },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } }
					]
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
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
