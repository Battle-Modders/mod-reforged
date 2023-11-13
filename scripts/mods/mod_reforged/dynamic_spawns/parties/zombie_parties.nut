local parties = [
	{
		ID = "Zombies",
		HardMin = 6,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true }
		]
	},
	{
		ID = "Ghosts",
		HardMin = 4,
		DefaultFigure = "figure_ghost_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 0.75,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.Ghost" }
		]
	},
	{
		ID = "ZombiesAndGhouls",
		HardMin = 8,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.GhoulLowOnly", RatioMin = 0.10, RatioMax = 0.30 }
		]
	},
	{
		ID = "ZombiesAndGhosts",
		HardMin = 8,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.12, RatioMax = 0.35 }
		]
	},
	{
		ID = "Necromancer",
		HardMin = 10,
		DefaultFigure = "figure_necromancer_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieFrontline", RatioMin = 0.50, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.Ghost", RatioMin = 0.00, RatioMax = 0.20 },
			{ BaseID = "UnitBlock.RF.NecromancerWithBodyguards", RatioMin = 0.04, RatioMax = 0.09, DeterminesFigure = true }
		]
	},
	{
		ID = "NecromancerSouthern",
		HardMin = 4,
		DefaultFigure = "figure_necromancer_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieSouthern", RatioMin = 0.65, RatioMax = 1.00 },
			{ BaseID = "UnitBlock.RF.NecromancerWithNomads", RatioMin = 0.04, RatioMax = 0.09, DeterminesFigure = true },
			{ BaseID = "UnitBlock.RF.ZombieElite", 	RatioMin = 0.00, RatioMax = 0.12 }
		]
	},
	{	// Only un-armored zombies
		ID = "ZombiesLight",
		HardMin = 6,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.ZombieLight" }
		]
	},

	// SubParties
	{
		ID = "SubPartyYeoman",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.RF.UndeadYeomanBodyguard" }
		]
	},
	{
		ID = "SubPartyKnight",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.RF.UndeadFallenHeroBodyguard" }
		]
	},
	{
		ID = "SubPartyYeomanKnight",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.RF.UndeadYeomanBodyguard" },
			{ BaseID = "UnitBlock.RF.UndeadFallenHeroBodyguard" }
		]
	},
	{
		ID = "SubPartyKnightKnight",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.RF.UndeadFallenHeroBodyguard" },
			{ BaseID = "UnitBlock.RF.UndeadFallenHeroBodyguard" }
		]
	},
	{	// The amount is set from outside
		ID = "SubPartyNomad",
		UnitBlockDefs = [
			{
				ID = "Zombie.ZombieNomadBodyguard"
			}
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
