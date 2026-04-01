// Vanilla: There are no parties with more than 1 Overseer and no parties with 2 Shaman without an Overseer. We allow it here for fight variety.
local parties = [
	{
		// Vanilla: Size 5-19, Cost 50-380
		// Variants: 30 of which (Num, CostMin - CostMax)
		// GoblinWolfrider (16, 80-380)
		// GoblinAmbusher (9, 60-160)
		// GoblinAmbusher, GoblinSkirmisher (1, 70-70)
		// GoblinSkirmisher (4, 50-75)
		ID = "GoblinRoamers",
		HardMin = 5,
		DefaultFigure = "figure_goblin_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", StartingResourceMax = 75 }, // No GoblinSkirmishers above 75 resources in vanilla
				{ BaseID = "UnitBlock.RF.GoblinRanged", StartingResourceMin = 60 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 80 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.GoblinFrontline");
			local ranged = this.getSpawnable("UnitBlock.RF.GoblinRanged");
			local flank = this.getSpawnable("UnitBlock.RF.GoblinFlank");

			// All vanilla parties above 160 resources have Wolfriders only
			if (res > 160)
			{
				frontline.HardMax = 0;
				ranged.HardMax = 0;
				return;
			}

			// In the absence of frontline, we have either Wolfriders only or Ambushers only
			if (!frontline.isValid())
			{
				if (flank.isValid() && ::Math.rand(1, 2) == 1)
				{
					ranged.HardMax = 0;
				}
				else
				{
					flank.HardMax = 0;
				}
			}
			// Frontline is present, chance to exclude ranged
			else if (::Math.rand(1, 100) <= 55)
			{
				ranged.HardMax = 0;
			}
		}
	},
	{
		// Vanilla: Size 5-11, Cost 75-200
		// Similar to GoblinRoamer except Scout sizes are capped in vanilla and they more mixed than Roamers. We have no cap in this implementation
		// Variants 15 of which (Num, CostMin - CostMax)
		// GoblinWolfrider (5, 80-160)
		// GoblinAmbusher, GoblinWolfrider (1, 120-120)
		// GoblinAmbusher, GoblinSkirmisher (9, 75-200)
		ID = "GoblinScouts",
		HardMin = 5,
		DefaultFigure = "figure_goblin_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline" },
				{ BaseID = "UnitBlock.RF.GoblinRanged", RatioMax = 0.65 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 80 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.GoblinFrontline");
			local ranged = this.getSpawnable("UnitBlock.RF.GoblinRanged");
			local flank = this.getSpawnable("UnitBlock.RF.GoblinFlank");

			if (flank.isValid())
			{
				local r = ::Math.rand(1, 100);
				// Chance to be Wolfriders and Ambushers only
				if (r <= 7)
				{
					frontline.HardMax = 0;
				}
				// Chance to be Wolfriders only
				else if (r <= 36)
				{
					frontline.HardMax = 0;
					ranged.HardMax = 0;
				}
				// Chance to be Skirmishers and Ambushers only
				else
				{
					flank.HardMax = 0;
				}
			}

			// Wolfriders absent
			if (!flank.isValid())
			{
				// In the absence of wolfriders we want at least 50% of the party to be ranged
				ranged.RatioMin = 0.5;
			}
		}
	},
	{
		// Vanilla: Size 5-36, Cost 55-695
		ID = "GoblinRaiders",
		HardMin = 5,
		DefaultFigure = "figure_goblin_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline", RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.GoblinRanged" },
				{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 80 }, // First appear in Skirmisher/Ambusher/Wolfrider 3/4/3 group at 185 Resources
				{ BaseID = "UnitBlock.RF.GoblinBoss", RatioMax = 0.07, HardMax = 1, StartingResourceMin = 275 }
				{ BaseID = "UnitBlock.RF.GoblinSupport", RatioMax = 0.07, HardMax = 3, StartingResourceMin = 275 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.GoblinFrontline");
			local ranged = this.getSpawnable("UnitBlock.RF.GoblinRanged");
			local flank = this.getSpawnable("UnitBlock.RF.GoblinFlank");
			local boss = this.getSpawnable("UnitBlock.RF.GoblinBoss");
			local support = this.getSpawnable("UnitBlock.RF.GoblinSupport");

			// Chance for a Wolfrider-only party
			if (flank.isValid())
			{
				local chanceFlankOnly = ::Reforged.Math.clamp(::Reforged.Math.multilerp(res, [
					[200, 25],
					[300, 33],
					[370, 0]
				]), 0, 33);
				if (::Math.rand(1, 100) <= chanceFlankOnly)
				{
					flank.StartingResourceMin = 80;
					frontline.HardMax = 0;
					ranged.HardMax = 0;
					boss.HardMax = 0;
					support.HardMax = 0;
					return;
				}
			}

			local isBossPresent = boss.isValid() && ::Math.rand(1, 100) > ::Reforged.Math.lerpClamp(res, 275, 60, 500, 0);
			if (isBossPresent)
			{
				boss.HardMin = 1;
				// Boss is always present with some Skirmishers and Ambushers
				frontline.HardMin = 8;
				ranged.HardMin = 5;
				// Shaman more likely to spawn in party with boss
				support.SpawnWeightMult = 3.5;

				flank.ExclusionChance = ::Reforged.Math.lerpClamp(res, 400, 0.45, 500, 0);
				frontline.RatioMin = ::Reforged.Math.lerpClamp(res, 275, 0.5, 700, 0.4);
				// Fewer Ranged at higher resources
				ranged.RatioMin = ::Reforged.Math.lerpClamp(res, 275, 0.4, 700, 0.18);
				ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 275, 0.4, 700, 0.25);
			}
			else
			{
				boss.HardMax = 0;
				flank.ExclusionChance = 25;
				support.ExclusionChance = 50;

				ranged.RatioMin = 0.2;
				ranged.RatioMax = 0.5;
				flank.RatioMax = ::Reforged.Math.lerpClamp(res, 185, 0.8, 450, 0.33);
			}
		}
	},
	{
		// Vanilla: Size 4-32, Cost 50-585
		ID = "GoblinDefenders",
		HardMin = 4,
		DefaultFigure = "figure_goblin_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline" },
				{ BaseID = "UnitBlock.RF.GoblinRanged", StartingResourceMin = 85 },
				{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 140 },
				{ BaseID = "UnitBlock.RF.GoblinBoss", HardMax = 1, StartingResourceMin = 220 }
				{ BaseID = "UnitBlock.RF.GoblinSupport",  RatioMax = 0.07, HardMax = 2, StartingResourceMin = 235 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.GoblinFrontline");
			local ranged = this.getSpawnable("UnitBlock.RF.GoblinRanged");
			local flank = this.getSpawnable("UnitBlock.RF.GoblinFlank");
			local boss = this.getSpawnable("UnitBlock.RF.GoblinBoss");
			local support = this.getSpawnable("UnitBlock.RF.GoblinSupport");

			// Some ranged units are always present above their StartingResourceMin.
			// Vanilla just has 1 party at 90 resources where they are absent.
			ranged.RatioMin = ::Reforged.Math.lerpClamp(res, 100, 0.25, 600, 0.2);
			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 100, 0.45, 600, 0.3);

			local isBossPresent = boss.isValid() && ::Math.rand(1, 100) > ::Reforged.Math.lerpClamp(res, 220, 65, 370, 0);
			if (isBossPresent)
			{
				boss.HardMin = 1;
				// Boss is always present with some Skirmishers and Ambushers
				frontline.HardMin = 6;
				ranged.HardMin = 4;
				// Shaman more likely to spawn in party with boss
				support.SpawnWeightMult = 1.7;

				flank.ExclusionChance = 33;
				frontline.RatioMin = 0.5;
			}
			else
			{
				boss.HardMax = 0;
				support.ExclusionChance = 60;
				if (flank.isValid())
				{
					// Some chance to be only Wolfriders as melee instead of Wolfriders and Skirmishers
					if (::Math.rand(1, 100) <= 30)
					{
						frontline.HardMax = 0;
					}
					// Skirmishers present as melee
					else
					{
						flank.RatioMax = 0.3;
						// Large chance to exclude Wolfriders when Skirmishers are present
						flank.ExclusionChance = ::Reforged.Math.lerpClamp(res, 230, 1.0, 325, 0.7);
					}
				}
			}
		}
	},
	{
		// 7/4/1, 9/7/1, 4/7/1, 11/3/1, Wolfriders in 6/5/5/1
		// Vanilla: Size 12-32, Cost 215-585
		ID = "GoblinBoss",
		HardMin = 12,
		DefaultFigure = "figure_goblin_01",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.GoblinFrontline" },
				{ BaseID = "UnitBlock.RF.GoblinRanged" },
				{ BaseID = "UnitBlock.RF.GoblinFlank", StartingResourceMin = 325 },
				{ BaseID = "UnitBlock.RF.GoblinBoss", HardMax = 1 }
				{ BaseID = "UnitBlock.RF.GoblinSupport",  RatioMax = 0.07, HardMax = 2, StartingResourceMin = 235 }
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.GoblinFrontline");
			local ranged = this.getSpawnable("UnitBlock.RF.GoblinRanged");
			local flank = this.getSpawnable("UnitBlock.RF.GoblinFlank");
			local boss = this.getSpawnable("UnitBlock.RF.GoblinBoss");
			local support = this.getSpawnable("UnitBlock.RF.GoblinSupport");

			frontline.RatioMin = ::Reforged.Math.lerpClamp(res, 400, 0.33, 500, 0.45);
			ranged.RatioMin = 0.2;
			ranged.RatioMax = ::Reforged.Math.lerpClamp(res, 300, 0.6, 600, 0.3);
			flank.RatioMax = 0.3;

			// Vanilla can have Overseer only, Shaman only, or both.
			if (!support.isValid())
			{
				// Guarantee an Overseer if Shaman is not valid.
				boss.HardMin = 1;
			}
			// Shaman is valid
			else
			{
				local r = ::Math.rand(1, 100);
				// Chance to be Shaman and Overseer both
				if (res > 300 && r <= ::Reforged.Math.lerpClamp(res, 300, 50, 500, 100))
				{
					boss.HardMin = 1;
					support.HardMin = 1;
				}
				// Otherwise high chance to be Overseer only
				else if (r <= ::Reforged.Math.lerpClamp(res, 300, 70, 400, 100))
				{
					boss.HardMin = 1;
					support.HardMax = 0;
				}
				// Shaman only
				else
				{
					boss.HardMax = 0;
					support.HardMin = 1;
				}
			}
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
