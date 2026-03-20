local parties = [
	{
		ID = "UndeadScourge",
		Variants = ::MSU.Class.WeightedContainer([
			[7, {
				ID = "UndeadScourge_0",
				HardMin = 8,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00, ExclusionChance = 0.15 },
						{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 350, ExclusionChance = 0.20  },
						{ BaseID = "UnitBlock.RF.GhoulMedium", RatioMin = 0.00, RatioMax = 0.20, StartingResourceMin = 350, ExclusionChance = 0.33 },	// Vanilla does not spawn T3 Ghouls. We allow it here
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.15, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.09, RatioMax = 0.35, ExclusionChance = 0.15 },
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.11, PartySizeMin = 20, ExclusionChance = 0.15 },
						{ BaseID = "UnitBlock.RF.ScourgeSupport", RatioMin = 0.00, RatioMax = 0.12, StartingResourceMin = 350, PartySizeMin = 14, HardMax = 3, ExclusionChance = 0.40 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 400, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", StartingResourceMin = 300, PartySizeMin = 12, HardMax = 1, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", StartingResourceMin = 400, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", StartingResourceMin = 500, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.80 },
						{ BaseID = "UnitBlock.RF.Banshee", StartingResourceMin = 500, PartySizeMin = 18, HardMax = 1, ExclusionChance = 0.80,  },
						{ BaseID = "UnitBlock.RF.Hollenhund", StartingResourceMin = 400, RatioMax = 0.12, HardMax = 3, ExclusionChance = 0.33 }
					],
				},

				function generateIdealSize()
				{
					return 12 + ::Math.max(0, (this.getTopParty().getStartingResources() - 250) / 50);
				}
			}],
			[1, {
				ID = "UndeadScourgeOrcs", // No regular zombie frontline
				HardMin = 8,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				DynamicDefs = {
					UnitBlocks = [
						{ BaseID = "UnitBlock.RF.NecromancerWithBodyguardsOrc", RatioMin = 0.01, HardMax = 1 },
						{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 350, ExclusionChance = 0.20  },
						{ BaseID = "UnitBlock.RF.GhoulMedium", RatioMin = 0.00, RatioMax = 0.20, StartingResourceMin = 350, ExclusionChance = 0.33 },	// Vanilla does not spawn T3 Ghouls. We allow it here
						{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.15, RatioMax = 1.00 },
						{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.09, RatioMax = 0.35, ExclusionChance = 0.15 },
						{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.11, PartySizeMin = 20, ExclusionChance = 0.15 },
						{ BaseID = "UnitBlock.RF.ScourgeSupportOrc", RatioMin = 0.00, RatioMax = 0.12, StartingResourceMin = 500, PartySizeMin = 18, HardMax = 2, ExclusionChance = 0.40 },
						{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 400, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonDecanus", StartingResourceMin = 300, PartySizeMin = 12, HardMax = 1, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonCenturion", StartingResourceMin = 400, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.50 },
						{ BaseID = "UnitBlock.RF.SkeletonLegatus", StartingResourceMin = 500, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.80 },
						{ BaseID = "UnitBlock.RF.Banshee", StartingResourceMin = 500, PartySizeMin = 18, HardMax = 1, ExclusionChance = 0.80,  },
						{ BaseID = "UnitBlock.RF.Hollenhund", StartingResourceMin = 400, RatioMax = 0.12, HardMax = 3, ExclusionChance = 0.33 }
					],
					Parties = [
						{ BaseID = "ZombieOrcs" }
					]
				},

				function generateIdealSize()
				{
					return 12 + ::Math.max(0, (this.getTopParty().getStartingResources() - 250) / 60);
				}
			}]
		])
	},
	// {
	// 	ID = "UndeadScourgeNorth", // Add Draugr, remove Ghoul
	// 	Variants = ::MSU.Class.WeightedContainer([
	// 		[7, {
	// 			ID = "UndeadScourgeNorth_0",
	// 			HardMin = 8,
	// 			DefaultFigure = "figure_skeleton_01",
	// 			MovementSpeedMult = 0.9,
	// 			VisibilityMult = 1.0,
	// 			VisionMult = 1.0,
	// 			DynamicDefs = {
	// 				UnitBlocks = [
	// 					{ BaseID = "UnitBlock.RF.DraugrStandard", ExclusionChance = 0.33 },
	// 					{ BaseID = "UnitBlock.RF.DraugrBoss", RatioMin = 0.00, RatioMax = 0.08, PartySizeMin = 18, ExclusionChance = 0.50 },
	// 					{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00, ExclusionChance = 0.15 },
	// 					{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 350, ExclusionChance = 0.20  },
	// 					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.15, RatioMax = 1.00 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.09, RatioMax = 0.35, ExclusionChance = 0.15 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.11, PartySizeMin = 20, ExclusionChance = 0.15 },
	// 					{ BaseID = "UnitBlock.RF.ScourgeSupport", RatioMin = 0.00, RatioMax = 0.12, StartingResourceMin = 350, PartySizeMin = 14, HardMax = 3, ExclusionChance = 0.40 },
	// 					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.18, StartingResourceMin = 400, ExclusionChance = 0.50 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonDecanus", StartingResourceMin = 300, PartySizeMin = 12, HardMax = 1, ExclusionChance = 0.50 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonCenturion", StartingResourceMin = 400, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.50 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonLegatus", StartingResourceMin = 500, PartySizeMin = 16, HardMax = 1, ExclusionChance = 0.80 },
	// 					{ BaseID = "UnitBlock.RF.Banshee", StartingResourceMin = 500, PartySizeMin = 18, HardMax = 1, ExclusionChance = 0.80,  },
	// 					{ BaseID = "UnitBlock.RF.Hollenhund", StartingResourceMin = 400, RatioMax = 0.12, HardMax = 3, ExclusionChance = 0.33 }
	// 				]
	// 			}

	// 			function generateIdealSize()
	//			{
	//				return 12 + ::Math.max(0, (this.getTopParty().getStartingResources() - 250) / 65);
	//			}
	// 		}],
	// 		[1, {
	// 			ID = "UndeadScourgeNorthOrcs",
	// 			HardMin = 8,
	// 			DefaultFigure = "figure_skeleton_01",
	// 			MovementSpeedMult = 0.9,
	// 			VisibilityMult = 1.0,
	// 			VisionMult = 1.0,
	// 			DynamicDefs = {
	// 				UnitBlocks = [
	// 					{ BaseID = "UnitBlock.RF.NecromancerWithZombieOrcs", RatioMin = 0.01, HardMax = 1 },
	// 					{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00 },
	// 					{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.12, PartySizeMin = 8 },
	// 					{ BaseID = "UnitBlock.RF.Ghoul", RatioMin = 0.00, RatioMax = 0.20, PartySizeMin = 12 },	// Vanilla does not spawn T3 Ghouls. We allow it here
	// 					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.15, RatioMax = 1.00 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.09, RatioMax = 0.35 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.11, PartySizeMin = 16 },
	// 					{ BaseID = "UnitBlock.RF.ScourgeSupport", RatioMin = 0.00, RatioMax = 0.12,  PartySizeMin = 22 },
	// 					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.11, PartySizeMin = 16 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.0, PartySizeMin = 10, HardMax = 1 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, PartySizeMin = 15, HardMax = 2 },
	// 					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, PartySizeMin = 18, HardMax = 1 },
	// 					{ BaseID = "UnitBlock.RF.DraugrStandard", RatioMin = 0.00, RatioMax = 0.3 },
	// 					{ BaseID = "UnitBlock.RF.DraugrHero", RatioMin = 0.00, RatioMax = 0.0, PartySizeMin = 18 },
	// 					{ BaseID = "UnitBlock.RF.Banshee", RatioMax = 0.0, PartySizeMin = 16, ExclusionChance = 0.50 },
	// 					{ BaseID = "UnitBlock.RF.Hollenhund", RatioMax = 0.0, PartySizeMin = 12, ExclusionChance = 0.33 }
	// 				],
	// 				Parties = [
	// 					{ BaseID = "ZombieOrcs", RatioMax = 0.2, ExclusionChance = 0.8 }
	// 				]
	// 			}
	// 		}]
	// 	]),
	// }
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
