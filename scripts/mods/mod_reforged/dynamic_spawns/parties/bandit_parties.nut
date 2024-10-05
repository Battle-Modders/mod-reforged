local parties = [
	{
		ID = "BanditRoamers", // Spawn from patrol contract and send bandit raomers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 1.0 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.10 }
		]
	},
	{
		ID = "BanditScouts", // Only spawn from restore location contract
		HardMin = 7,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 1.0 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 0.10 },
			{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.20, ExclusionChance = 0.10 }
		]
	},
	{
		ID = "BanditRaiders",  // Spawn from defend settlment contract, discover location contract, escort caravan contract, investigate cemetary contract, patrol contract, return item contract, root out undead contract and send bandit ambushers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 1.0 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.10 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.10 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.10, StartingResourceMin = 320 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.11, ExclusionChance = 0.75, StartingResourceMin = 250, DeterminesFigure = true }
		]
	},
	{
		ID = "BanditDefenders",  // Spawn from deliver item contract, drive away bandits contract, bandit camp locations, bandit hideout locations, bandit ruins locations, man in forest event and defend bandits action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 1.0 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.10 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.0, RatioMax = 0.11, StartingResourceMin = 250 }
		]
	},
	{
		ID = "BanditBoss",
		HardMin = 9,
		DefaultFigure = "figure_bandit_04",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 1.0 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30, ExclusionChance = 0.20 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.01, RatioMax = 0.11 }  // One boss is always guaranteed
		]
	},
	{
		ID = "BanditsDisguisedAsDirewolves", // Only spawn from roaming beasts contract.
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditDisguisedDirewolf" }
		],
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
