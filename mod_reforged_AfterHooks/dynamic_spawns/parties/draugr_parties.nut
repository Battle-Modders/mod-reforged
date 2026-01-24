local parties = [
	// CURRENTLY UNUSED
	// {
	// 	ID = "RF_DraugrRoamers",
	// 	HardMin = 8,
	// 	// DefaultFigure = "figure_bandit_01",
	// 	DynamicDefs = {
	// 		UnitBlocks = [
	// 			{ BaseID = "UnitBlock.RF.DraugrStandard", RatioMin = 0.00, RatioMax = 1.0 }
	// 		]
	// 	}
	// },
	{
		ID = "RF_DraugrBarrows",
		HardMin = 9,
		// DefaultFigure = "figure_bandit_01",
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrHuskarl" }
			]
		},
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.DraugrStandard", RatioMin = 0.00, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.DraugrShaman", HardMin = 1, HardMax = 1 }
			],
			Units = [
					{ BaseID = "Unit.RF.RF_DraugrThrall", function onBeforeSpawnStart() { this.HardMin = ::Math.rand(1, 5); this.HardMax = HardMin;} },
					{ BaseID = "Unit.RF.RF_DraugrWarrior", function onBeforeSpawnStart() { this.HardMin = ::Math.rand(1, 3); this.HardMax = HardMin;} }
			 ]
		}

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.RF_DraugrHuskarl").StartingResourceMin = 5000; // we want Barrows to have 1 Huskarl only
		}

		function getUpgradeChance()
		{
			if (this.getTopParty().getStartingResources() >= 600)
			{
				return 60;
			}
			else
			{
				return 15;
			}
		}
	},
	{
		// Thrall/Warrior/Huskarl ratio goes from 0.84/1/0.55 at 400 to 0.37/1/0.63 at 1200.
		ID = "RF_DraugrCrypt",
        // DefaultFigure = "figure_bandit_01",
        StaticDefs = {
            Units = [
                { BaseID = "Unit.RF.RF_DraugrHero" }
            ]
        },
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.DraugrStandard", RatioMin = 0.00, RatioMax = 1.0 },
                { BaseID = "UnitBlock.RF.DraugrShaman", HardMin = 1, HardMax = 1 }
            ]
        }

		function getUpgradeChance()
		{
			return this.getTotal() * ::Math.maxf(3.0, 7.0 - 0.000001 * ::Math.pow(this.getTopParty().getStartingResources(), 2.25));
		}
	},
	{
		ID = "RF_DraugrFane",
		// DefaultFigure = "figure_bandit_01",
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrHeroChampion" }
			]
		},
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_DraugrHero",
					function onBeforeSpawnStart()
					{
						local c = ::MSU.Class.WeightedContainer([
							[60, 1], // Weight, Output
							[30, 2],
							[10, 3]
						]);

						if (this.getTopParty().getStartingResources() >= 900)
						{
							c.add(1, 15); // Output, Weight
							c.add(2, 50);
							c.add(3, 35);
						}

						this.HardMin = c.roll();
						this.HardMax = this.HardMin;
					},
				}
			],
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.DraugrStandard", RatioMin = 0.00, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.DraugrShaman", HardMin = 1, HardMax = 1 }
			]
		}

		function getUpgradeChance()
		{
			return this.getTotal() * ::Math.maxf(0.0, 5.0 + 0.000015 * ::Math.pow(this.getTopParty().getStartingResources(), 1.60));
		}
	}

	// SubParties
	{
		ID = "RF_DraugrShamanBodyguards",
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.DraugrBodyguard", RatioMin = 0.00, RatioMax = 1.00 }
			]
		}

		function getDefaultResources()
		{
			return this.getTopParty() == this ? base.getDefaultResources() : this.getTopParty().getStartingResources() * 0.12 * ::MSU.Math.randf(0.8, 1.2);
		}

		function onBeforeSpawnStart()
		{
			local c = ::MSU.Class.WeightedContainer([
				[2, 1], // Weight, Output
				[1, 2]
			]);

			if (this.getTopParty().getStartingResources() >= 400)
			{
				c.add(1, 1); // Output, Weight
				c.add(2, 2); // Output, Weight
			}

			this.HardMin = c.roll();
			this.HardMax = this.HardMin;
		}
	},
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
