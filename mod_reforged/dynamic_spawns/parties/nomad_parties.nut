local parties = [
	{
		// Vanilla: Size 6-18, Cost 72-216; Cutthroat/Outlaw/Ranged/Elite,
		ID = "NomadRoamers",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",  // Icon for Cutthroats
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.50, RatioMax = 0.80
					function getUpgradeWeight() { return base.getUpgradeWeight() * 1.0; }
				},
				{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.2, RatioMax = 0.50
					function getUpgradeWeight() { return base.getUpgradeWeight() * 0.1; }
					function getSpawnWeight() { return base.getSpawnWeight() * 0.3; }
				}
			]
		}

		function getUpgradeChance()
		{
			return 40;
		}
	},
	{
		// Vanilla: Size 6-27, Cost 72-625
		ID = "NomadRaiders",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",  // Icon for Cutthroats
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.25, RatioMax = 1.00
					function getUpgradeWeight() { return base.getUpgradeWeight() * 2.0; }
					function getSpawnWeight() { return base.getSpawnWeight() * 1.0; }
				},
				{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.00
					function getRatioMax() { return base.getRatioMax() * (this.getParty().getStartingResources() > 350 ? 0.40 : 0.33); }
					function getUpgradeWeight() { return base.getUpgradeWeight() * (this.getParty().getStartingResources() > 350 ? 0.8 : 0.8); }
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 150)
						{
							return base.getSpawnWeight() * 1.5;
						}
						else
						{
							return base.getSpawnWeight() * 0.45;
						}
					}
				}
				{ BaseID = "UnitBlock.RF.NomadLeader", RatioMin = 0.00, StartingResourceMin = 250
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 500)
						{
							return base.getSpawnWeight() * 0.70;
						}
						else if (this.getTopParty().getStartingResources() >= 330)
						{
							return base.getSpawnWeight() * 0.60;
						}
						else
						{
							return base.getSpawnWeight() * 0.40;
						}
					}

					 function getRatioMax() {
					if (this.getTopParty().getStartingResources() >= 400)
						{
							return base.getRatioMax() * 0.10;
						}
						else
						{
							return base.getRatioMax() * 0.07;
						}
					}
				},  // They spawn as early as with 7 troops in vanilla. But 2 only start spawning in 23+
				{ BaseID = "UnitBlock.RF.NomadElite", RatioMin = 0.00, RatioMax = 0.30, StartingResourceMin = 350	// In Vanilla they appear in a group of 350 cost
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 580)
						{
							return base.getSpawnWeight() * 1.70;
						}
						else
						{
							return base.getSpawnWeight() * 0.07;
						}
					}
				}
			]
		}

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.NomadArcher").StartingResourceMin = 142;
		}

		function getUpgradeChance()
		{
			if (this.getTopParty().getStartingResources() >= 300)
			{
				return 80;
			}
			else
			{
				return 60;
			}
		}
	},
	{
		// Vanilla: Size 5-31, Cost 60-770
		ID = "NomadDefenders",
		HardMin = 4,
		DefaultFigure = "figure_nomad_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.NomadFrontline", RatioMin = 0.25, RatioMax = 1.00
					function getUpgradeWeight() { return base.getUpgradeWeight() * 1.0; }
					function getSpawnWeight() { return base.getSpawnWeight() * (this.getParty().getStartingResources() > 400 ? 0.7 : 1.0); }
					//function getSpawnWeight() { return base.getSpawnWeight() * 1.0; }
				},
				{ BaseID = "UnitBlock.RF.NomadRanged", RatioMin = 0.00,
					function getRatioMax() { return base.getRatioMax() * (this.getParty().getStartingResources() > 350 ? 0.45 : 0.80); }
					function getUpgradeWeight() { return base.getUpgradeWeight() * (this.getParty().getStartingResources() > 350 ? 0.8 : 0.6); }
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 500)
						{
							return base.getSpawnWeight() * 0.9;
						}
						else if (this.getTopParty().getStartingResources() >= 400)
						{
							return base.getSpawnWeight() * 0.5;
						}
						else if (this.getTopParty().getStartingResources() >= 250)
						{
							return base.getSpawnWeight() * 0.3;
						}
						else
						{
							return base.getSpawnWeight() * 0.18;
						}
					}
				}
				{ BaseID = "UnitBlock.RF.NomadLeader", RatioMin = 0.00, StartingResourceMin = 175
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 500)
						{
							return base.getSpawnWeight() * 0.75;
						}
						else if (this.getTopParty().getStartingResources() >= 330)
						{
							return base.getSpawnWeight() * 1.0;
						}
						else
						{
							return base.getSpawnWeight() * 0.40;
						}
					}

					 function getRatioMax() {
						if (this.getTopParty().getStartingResources() >= 540)
						{
							return base.getRatioMax() * 0.12;
						}
						 else if (this.getTopParty().getStartingResources() >= 350)
						{
							return base.getRatioMax() * 0.09;
						}
						else
						{
							return base.getRatioMax() * 0.08;
						}
					}
				},
				{ BaseID = "UnitBlock.RF.NomadElite", RatioMin = 0.00, RatioMax = 0.30, StartingResourceMin = 450
					function getSpawnWeight() {
						if (this.getTopParty().getStartingResources() >= 750)
						{
							return base.getSpawnWeight() * 1.0;
						}
						else if (this.getTopParty().getStartingResources() >= 520)
						{
							return base.getSpawnWeight() * 0.17;
						}
						else
						{
							return base.getSpawnWeight() * 0.07;
						}
					}
				}
			]
		}

		function onBeforeSpawnStart()
		{
			this.getSpawnable("Unit.RF.NomadArcher").StartingResourceMin = 150;
		}

		function getUpgradeChance()
		{
			if (this.getTopParty().getStartingResources() >= 300)
			{
				return 80;
			}
			else
			{
				return 60;
			}
		}
	}
]

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
