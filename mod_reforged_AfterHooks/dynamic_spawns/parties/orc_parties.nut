local parties = [
	{
		// Vanilla: Size 4-14, Cost 64-260 Orc Young Orc Berserkers. Spawns Composition: Young/Young & Berserkers 6/6.
		ID = "OrcRoamers", // Send Orc Roamers action
        HardMin = 4,
        DefaultFigure = "figure_orc_01",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.55, RatioMax = 1.00 },
                { BaseID = "UnitBlock.RF.OrcBerserker",  StartingResourceMin = 75, ExclusionChance = 0.20,
                    function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() < 150 ? 0.25 : 0.5); }
                }
            ]
        }
	},
	{	// Vanilla: Size: 4-11, Cost 52-176. Spawns Composition: Young/Young & Warrior 13/2. Only ever 1 Orc Warrior.
		ID = "OrcScouts",
        HardMin = 4,
        DefaultFigure = "figure_orc_01",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.00, RatioMax = 1.00 },
                { BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.66, StartingResourceMin = 100 // Vanilla spawns at 104 resources.
                    function getSpawnWeight() { return base.getSpawnWeight() * 0.2; }
                }
            ]
        }
	},
	{
		// Vanilla: Size: 5-26, Cost 77-822. Young/Young & Warrior/Young & Berserkers/Young & Warrior & Berserker: 14/15/6/5 Warlord Spawns: 15.
		ID = "OrcRaiders",
        HardMin = 5,
        DefaultFigure = "figure_orc_01",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00,
                    function getSpawnWeight() {    // Lategame Parties will have fewer Young in them
                        local mult = 1.0;
                        local res = this.getParty().getStartingResources();
                        if (res > 400) mult = 0.01;
                        else if (res > 350) mult = 0.05;
                        else if (res > 250) mult = 0.3;
                        return base.getSpawnWeight() * mult;
                    }
                },
                { BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.25,  StartingResourceMin = 100, // Vanilla: First appears in party of 5 with 77 resources.
                    function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.7 : 0.5; },
                    function getSpawnWeight() { return base.getSpawnWeight() * 0.5 }
                },
                { BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.50,  StartingResourceMin = 100, // Vanilla: First appears in party of 5 with 94 resources
                    function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.6 : 0.3; },
                    function getSpawnWeight() { return base.getSpawnWeight() *  2.0 }
                },
                { BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.08, HardMax = 1,  StartingResourceMin = 400,
                    function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() <= 450 ? 0.1 : 1.25); }    // Vanilla never spawns more than one Boss here
                }
            ]
        }
	},
	{
		ID = "OrcDefenders", // Vanilla: Size: 4-23, Cost 64-720. Orc Camp location and Defend Orcs Action  Young/Young & Berserker/Young & Warrior/Young & Warrior & Berserker 11/8/4/7 Warlord Spawns: 9.
        HardMin = 4,
        DefaultFigure = "figure_orc_01",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00,
                    function getSpawnWeight() { // Lategame Parties will have fewer Young in them
                        local mult = 3.0;
                        local res = this.getParty().getStartingResources();
                        if (res > 400) mult = 0.3;
                        else if (res > 350) mult = 0.6;
                        else if (res > 250) mult = 0.8;
                        return base.getSpawnWeight() * mult;
                    }
                },
                { BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.30, StartingResourceMin = 100, // Vanilla: First Berserker in a party of 4 with 73 resources.
                    function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.7 : 0.5; },
                    function getSpawnWeight() { return base.getSpawnWeight() * 2.0 }
                },
                { BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.80, StartingResourceMin = 100, // Vanilla: First Warrior in a party of 5 with 94 resources.
                    function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() <= 200 ? 0.3 : 0.6); }
                },
                { BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.08, HardMax = 1, StartingResourceMin = 200,
                    function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() <= 350 ? 0.10 : 0.7); }    // Vanilla never spawns more than one Boss here
                }
            ]
        }
	},
	{
		ID = "OrcBoss", // // Vanilla: Size: 6-32, Cost 164-798.Young/Young & Berserker/Young & Warrior/Young & Warrior & Berserker /// Warlord Spawns: .   Orc Settlement Location
        HardMin = 8,
        DefaultFigure = "figure_orc_05",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00,
                    function getSpawnWeight() {
                        local mult = 3.0;
                        local res = this.getParty().getStartingResources();
                        if (res > 400) mult = 1.0;
                        else if (res > 350) mult = 0.8;
                        else if (res > 250) mult = 0.9;
                        return base.getSpawnWeight() * mult;
                    }
                },
                { BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50
                     function getSpawnWeight() { return base.getSpawnWeight() * 0.4 }
                },
                { BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.80,
                    function getSpawnWeight() { return base.getSpawnWeight() * 0.8 }
                },
                { BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.01, RatioMax = 0.05, HardMax = 1 }    // Vanilla never spawns more than one Boss here
            ]
        }
	},
	{	// In Vanilla these never spawn OrcYoungLOW but here they do
		ID = "YoungOrcsOnly", // Orc Hideout Location
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				"UnitBlock.RF.OrcYoung"
			]
		}
	},
	{	// In Vanilla these never spawn OrcYoungLOW but here they do
		ID = "YoungOrcsAndBerserkers", // Orc Ruins Location
		HardMin = 3,		// In Vanilla this is 2 when spawning Berserker only
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung" },
				{ BaseID = "UnitBlock.RF.OrcBerserker",
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5; }
				}
			]
		},

		function excludeSpawnables()
		{
			if (this.__DynamicSpawnables.len() == 2 && ::Math.rand(1, 100) <= 50) // 50% chance to remove one or the other
			{
				this.__DynamicSpawnables.remove(::Math.rand(0, 1));
			}
			base.excludeSpawnables();
		}
	},
	{
		ID = "BerserkersOnly",
        HardMin = 2, // Orc Cave location and Confront Warlord Contract
        DefaultFigure = "figure_orc_03",
        MovementSpeedMult = 1.0,
        VisibilityMult = 1.0,
        VisionMult = 1.0,
        DynamicDefs = {
            UnitBlocks = [
                { BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.0, RatioMax = 0.40, PartySizeMin = 3, ExclusionChance = 0.3,
                    function getSpawnWeight() { return base.getSpawnWeight() * 0.2; }
                },
                { BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.6, RatioMax = 1.0 }
            ]
        }
	}
]

foreach (partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
