local parties = [
	{
		ID = "Zombies",
		HardMin = 6,
		DefaultFigure = "figure_zombie_01",
		MovementSpeedMult = 0.8,
		VisibilityMult = 1.0,
		VisionMult = 0.8,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.ZombieFrontline", 	RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true}
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
			{ BaseID = "UnitBlock.ZombieGhost" }
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
			{ BaseID = "UnitBlock.ZombieFrontline", 		RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.BeastGhoulLowOnly", 	RatioMin = 0.10, RatioMax = 0.30},
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
			{ BaseID = "UnitBlock.ZombieFrontline", 		RatioMin = 0.00, RatioMax = 1.00, DeterminesFigure = true},
			{ BaseID = "UnitBlock.ZombieGhost", 			RatioMin = 0.12, RatioMax = 0.35},
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
			{ BaseID = "UnitBlock.ZombieFrontline", 						RatioMin = 0.50, RatioMax = 1.00},
			{ BaseID = "UnitBlock.ZombieGhost", 							RatioMin = 0.00, RatioMax = 0.20},
			{ BaseID = "UnitBlock.ZombieNecromancerWithBodyguards", 		RatioMin = 0.04, RatioMax = 0.09, DeterminesFigure = true},
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
			{ BaseID = "UnitBlock.ZombieSouthern", 					RatioMin = 0.65, RatioMax = 1.00},
			{ BaseID = "UnitBlock.ZombieNecromancerWithNomads", 		RatioMin = 0.04, RatioMax = 0.09, DeterminesFigure = true},
			{ BaseID = "UnitBlock.ZombieElite", 						RatioMin = 0.00, RatioMax = 0.12, StartingResourceMin = 200},
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
			{ BaseID = "UnitBlock.ZombieLight" }
		]
	},

	// SubParties
	{
		ID = "SubPartyYeoman",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.UndeadYeomanBodyguard" }
		]
	},
	{
		ID = "SubPartyKnight",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.UndeadFallenHeroBodyguard" }
		]
	},
	{
		ID = "SubPartyYeomanKnight",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.UndeadYeomanBodyguard" },
			{ BaseID = "UnitBlock.UndeadFallenHeroBodyguard" }
		]
	},
	{
		ID = "SubPartyKnightKnight",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "UnitBlock.UndeadFallenHeroBodyguard" },
			{ BaseID = "UnitBlock.UndeadFallenHeroBodyguard" }
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
	{
		ID = "SubPartyHonor",
		HardMin = 1,
		StaticUnitIDs = [
			"Undead.SkeletonHeavyBodyguard"
		]
	},
	{
		ID = "SubPartyHonorHonor",
		HardMin = 2,
		StaticUnitIDs = [
			"Undead.SkeletonHeavyBodyguard",
			"Undead.SkeletonHeavyBodyguard"
		]
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
