local parties = [
	{
		ID = "UndeadArmy",
		Variants = ::MSU.Class.WeightedContainer([
			[3, {
				ID = "UndeadArmy_0",
				HardMin = 4,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
					if (startingResources >= 350)
					{
						return 12;
					}
					else if (startingResources >= 300)
					{
						return 11;
					}
					else if (startingResources >= 250)
					{
						return 10;
					}
					else if (startingResources >= 180)
					{
						return 9;
					}
					else if (startingResources >= 120)
					{
						return 7;
					}
					else
					{
						return 5;
					}
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.40, RatioMax = 1.0 },
					{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.00, RatioMax = 0.40 },
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.30, function getSpawnWeight(){ return base.getSpawnWeight() * 0.3 } },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.75, StartingResourceMin = 220, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMin = 0.00, RatioMax = 0.20, HardMax = 3, StartingResourceMin = 180, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMin = 0.00, RatioMax = 0.15, HardMax = 2, StartingResourceMin = 250, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 }  },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMin = 0.00, RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.10, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
				]
			}],
			[1, {
				ID = "UndeadArmy_1",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 300,

				function generateIdealSize( _isLocation = false )
				{
					return 8;
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, StartingResourceMin = 250, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.20, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
				]
			}],
			[1, {
				ID = "UndeadArmy_2",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,

				function generateIdealSize( _isLocation = false )
				{
					return 8;
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.80 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, StartingResourceMin = 220 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } },
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.20, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
				]
			}],
			[1, {
				ID = "UndeadArmy_3",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,

				function generateIdealSize( _isLocation = false )
				{
					return 8;
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 180, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
				]
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

		function generateIdealSize( _isLocation = false )
		{
			return 7;
		}

		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.VampireOnly", RatioMin = 0.01, RatioMax = 1.00 }
		]
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

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
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

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 1.00 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, HardMin = 3, function getSpawnWeight(){ return base.getSpawnWeight() * 0.5 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.1 } },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.20, StartingResourceMin = 180, HardMax = 3, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, StartingResourceMin = 250, HardMax = 2, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.15 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, StartingResourceMin = 300, HardMax = 1, ReqPartySize = 6, function getSpawnWeight(){ return base.getSpawnWeight() * 0.1 } }
				]
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

				function generateIdealSize( _isLocation = false )
				{
					return 9;
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.50, HardMin = 3, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, ReqPartySize = 4, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, ReqPartySize = 5, function getSpawnWeight(){ return base.getSpawnWeight() * 0.15 } }
				]
			}],
			[1, {
				ID = "VampiresAndSkeletons_2",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
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

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 0.70, function getUpgradeWeight(){ return base.getUpgradeWeight() * 1.5 } },
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70, function getSpawnWeight(){ return base.getSpawnWeight() * 0.75 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.2 } },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.70, HardMin = 3, function getSpawnWeight(){ return base.getSpawnWeight() * 0.75 }, function getUpgradeWeight(){ return base.getUpgradeWeight() * 0.1 } },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.20, HardMax = 3, StartingResourceMin = 180, function getSpawnWeight(){ return base.getSpawnWeight() * 0.3 } },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.10, HardMax = 2, StartingResourceMin = 250, function getSpawnWeight(){ return base.getSpawnWeight() * 0.3 } },
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.10, HardMax = 1, StartingResourceMin = 300, function getSpawnWeight(){ return base.getSpawnWeight() * 0.2 } }
				]
			}]
		])
	},
	{
		ID = "SubPartyPrae",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" }
		]
	},
	{
		ID = "SubPartyPrae2",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" },
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" }
		]
	},
	{
		ID = "SubPartyPraeHonor",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" },
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
		]
	},
	{
		ID = "SubPartyHonor2",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" },
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
		]
	},
	// {
	// 	ID = "SubPartySkeletonHeavy",
	// 	UnitBlockDefs = [
	// 		{ ID = "UnitBlock.RF_SkeletonHeavyBodyguard", RatioMin = 0.01, RatioMax = 1.00}
	// 	]
	// }
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
