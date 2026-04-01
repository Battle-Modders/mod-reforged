local parties = [
	{
		// Vanilla: Size 8-54, Cost 75-1203, Variants 146
		ID = "UndeadScourge",
		HardMin = 8,
		UpgradeChance = 50,
		MovementSpeedMult = 0.9,
		DynamicDefs = {
			Parties = [
				{
					ID = "Skeletons",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.SkeletonFrontline" }
							{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMax = 0.2, StartingResourceMin = 115 },
							{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMax = 0.11, PartySizeMin = 20, StartingResourceMin = 214 },
							{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMax = 0.12, StartingResourceMin = 295, PartySizeMin = 12, HardMax = 2, ExclusionChance = 40 },
							{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.1, PartySizeMin = 12, HardMax = 1, ExclusionChance = 50 },
							{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.05, PartySizeMin = 16, HardMax = 1, ExclusionChance = 50 },
							{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.05, PartySizeMin = 16, HardMax = 1, ExclusionChance = 80 },
							{ BaseID = "UnitBlock.RF.Vampire", RatioMax = 0.18, StartingResourceMin = 215, ExclusionChance = 20 }
						]
					}
				},
				{
					ID = "Zombies",
					DynamicDefs = {
						UnitBlocks = [
							{ BaseID = "UnitBlock.RF.ZombieFrontline" },
							{ BaseID = "UnitBlock.RF.NecromancerUpgrade", RatioMax = 0.18, StartingResourceMin = 215, ExclusionChance = 50 },
							{ BaseID = "UnitBlock.RF.GhoulMedium", RatioMax = 0.2, StartingResourceMin = 340, ExclusionChance = 33 },
							{ BaseID = "UnitBlock.RF.Ghost", RatioMax = 0.2, StartingResourceMin = 325, ExclusionChance = 20 },
							{ BaseID = "UnitBlock.RF.Banshee", StartingResourceMin = 350, PartySizeMin = 18, HardMax = 1, ExclusionChance = 70 },
							{ BaseID = "UnitBlock.RF.Hollenhund", RatioMax = 0.15, StartingResourceMin = 325, HardMax = 3, ExclusionChance = 33 }
						],
						Parties = [
							{ BaseID = "ZombieOrcs", RatioMax = 0.0, ExclusionChance = 50 }
						]
					}
				}
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local skeletonSupport = this.getSpawnable("UnitBlock.RF.SkeletonSupport");
			local necromancer = this.getSpawnable("UnitBlock.RF.NecromancerUpgrade");
			local skeletons = this.getSpawnable("Skeletons");
			local zombies = this.getSpawnable("Zombies");

			local r = ::Math.rand(1, 2);

			local chosen;
			if (r == 1)
			{
				chosen = zombies;
				if (skeletonSupport != null)
					skeletonSupport.SpawnWeightMult = 0.1;
			}
			else
			{
				chosen = skeletons;
				if (necromancer != null)
					necromancer.SpawnWeightMult = 0.1;
			}

			chosen.RatioMin = 0.6;
		}

		function onCycle( _cycler )
		{
			local necromancer = this.getSpawnable("UnitBlock.RF.NecromancerUpgrade");
			if (necromancer != null && necromancer.getTotal() != 0)
			{
				// Enable Zombie Orcs to spawn only when a Necromancer is present.
				local zombieOrcs = this.getSpawnable("ZombieOrcs");
				if (zombieOrcs != null)
					zombieOrcs.RatioMax = 1.0;
			}
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
