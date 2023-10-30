local parties = [
	{
		ID = "BanditRoamers", // Spawn from patrol contract and send bandit raomers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ ID = "Bandit.Balanced", RatioMin = 0.20, RatioMax = 0.70},
			{ ID = "Bandit.Fast", RatioMin = 0.00, RatioMax = 0.40},
			{ ID = "Bandit.Tough", RatioMin = 0.00, RatioMax = 0.40},
			{ ID = "Bandit.Ranged", RatioMin = 0.00, RatioMax = 0.35},
			{ ID = "Bandit.Dogs", RatioMin = 0.00, RatioMax = 0.20}
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
			{ ID = "Bandit.Balanced", RatioMin = 0.30, RatioMax = 0.70},
			{ ID = "Bandit.Fast", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Tough", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Ranged", RatioMin = 0.00, RatioMax = 0.40},
			{ ID = "Bandit.Dogs", RatioMin = 0.00, RatioMax = 0.20}
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
			{ ID = "Bandit.Balanced", RatioMin = 0.30, RatioMax = 0.70},
			{ ID = "Bandit.Fast", RatioMin = 0.00, RatioMax = 0.25},
			{ ID = "Bandit.Tough", RatioMin = 0.00, RatioMax = 0.25},
			{ ID = "Bandit.Ranged", RatioMin = 0.00, RatioMax = 0.35},
			{ ID = "Bandit.Elite", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 320},
			{ ID = "Bandit.Boss", RatioMin = 0.00, RatioMax = 0.11, StartingResourceMin = 180}
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
			{ ID = "Bandit.Balanced", RatioMin = 0.40, RatioMax = 0.70},
			{ ID = "Bandit.Fast", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Tough", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Ranged", RatioMin = 0.00, RatioMax = 0.25},
			{ ID = "Bandit.Elite", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 320},
			{ ID = "Bandit.Boss", RatioMin = 0.0, RatioMax = 0.11, StartingResourceMin = 180}
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
			{ ID = "Bandit.Balanced", RatioMin = 0.40, RatioMax = 0.70},
			{ ID = "Bandit.Fast", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Tough", RatioMin = 0.00, RatioMax = 0.30},
			{ ID = "Bandit.Ranged", RatioMin = 0.00, RatioMax = 0.25},
			{ ID = "Bandit.Elite", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 320},
			{ ID = "Bandit.Boss", RatioMin = 0.01, RatioMax = 0.11}				// One boss is always guaranteed
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
			{ ID = "Bandit.DisguisedDirewolf" }
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
