local parties = [
	{
		ID = "OrcRoamers", // Send Orc Roamers action
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.55, RatioMax = 1.00, DeterminesFigure = true },
				{ BaseID = "UnitBlock.RF.OrcBerserker", DeterminesFigure = true, StartingResourceMin = 75, ExclusionChance = 0.45,
					function getSpawnWeight() {	return base.getSpawnWeight() * (this.getParty().getStartingResources() < 150 ? 0.75 : 15); }
				}
			]
		}
	},
	{	// This is currently the same as OrcRoamers. I couldn't spot differences in Vanilla
		ID = "OrcScouts",
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true },
				{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.09, StartingResourceMin = 150,
					function getSpawnWeight() { return base.getSpawnWeight() * 0.2; }
				}
			]
		}
	},
	{
		ID = "OrcRaiders",
		HardMin = 5,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true,
					function getSpawnWeight() {	// Lategame Parties will have fewer Young in them
						local mult = 1.0;
						local res = this.getParty().getStartingResources();
						if (res > 400) mult = 0.01;
						else if (res > 350) mult = 0.05;
						else if (res > 250) mult = 0.3;
						return base.getSpawnWeight() * mult;
					}
				},
				{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.45, DeterminesFigure = true, StartingResourceMin = 175,
					function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.7 : 0.5; },
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5 }
				},
				{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.80, DeterminesFigure = true, StartingResourceMin = 200,
					function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.6 : 0.3; },
					function getSpawnWeight() { return base.getSpawnWeight() *  2.0 }
				},
				{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.08, HardMax = 1, DeterminesFigure = true, StartingResourceMin = 400,
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() <= 450 ? 0.1 : 1.25); }	// Vanilla never spawns more than one Boss here
				}
			]
		}
	},
	{
		ID = "OrcDefenders", // Orc Camp location and Defend Orcs Action
		HardMin = 4,
		DefaultFigure = "figure_orc_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true,
					function getSpawnWeight() { // Lategame Parties will have fewer Young in them
						local mult = 1.0;
						local res = this.getParty().getStartingResources();
						if (res > 400) mult = 0.01;
						else if (res > 350) mult = 0.05;
						else if (res > 250) mult = 0.3;
						return base.getSpawnWeight() * mult;
					}
				},
				{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.45, StartingResourceMin = 100,
					function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.7 : 0.5; },
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5 }
				},
				{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.80, StartingResourceMin = 150,
					function getExclusionChance() {return this.getParty().getStartingResources() < 300 ? 0.6 : 0.3; },
					function getSpawnWeight() { return base.getSpawnWeight() * 2.0 }
				},
				{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.00, RatioMax = 0.08, HardMax = 1, StartingResourceMin = 200,
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() <= 350 ? 0.10 : 0.7); }	// Vanilla never spawns more than one Boss here
				}
			]
		}
	},
	{
		ID = "OrcBoss", // Orc Settlement Location
		HardMin = 8,
		DefaultFigure = "figure_orc_05",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.OrcYoung", RatioMin = 0.15, RatioMax = 1.00, DeterminesFigure = true,
					function getSpawnWeight() { // Lategame Parties will have fewer Young in them
						local mult = 1.0;
						local res = this.getParty().getStartingResources();
						if (res > 400) mult = 0.01;
						else if (res > 350) mult = 0.05;
						else if (res > 250) mult = 0.3;
						return base.getSpawnWeight() * mult;
					}
				},
				{ BaseID = "UnitBlock.RF.OrcBerserker", RatioMin = 0.00, RatioMax = 0.50,
					function getExclusionChance() {	return this.getParty().getStartingResources() < 300 ? 0.5 : 0.5; }
				},
				{ BaseID = "UnitBlock.RF.OrcWarrior", RatioMin = 0.00, RatioMax = 0.80,
					function getExclusionChance() { return this.getParty().getStartingResources() < 300 ? 0.6 : 0.3; },
					function getSpawnWeight() { return base.getSpawnWeight() * 2.0 }
				},
				{ BaseID = "UnitBlock.RF.OrcBoss", RatioMin = 0.01, RatioMax = 0.05, HardMax = 1 }	// Vanilla never spawns more than one Boss here
			]
		}

	},
	{	// In Vanilla these never spawn OrcYoungLOW but here they do
		ID = "YoungOrcsOnly", // Orc Hideout Location
		HardMin = 4,		// In Vanilla this is 2 when spawning Berserker only
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
				{ BaseID = "UnitBlock.RF.OrcYoung", DeterminesFigure = true },
				{ BaseID = "UnitBlock.RF.OrcBerserker", DeterminesFigure = true,
					function getSpawnWeight() { return base.getSpawnWeight() * 0.5; }
				}
			]
		},

		function excludeSpawnables()
		{
			if (this.__DynamicSpawnables.len() == 2 && ::Math.rand(1, 100) <= 50)
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
					function getSpawnWeight() { return base.getSpawnWeight() * 0.1; }
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

