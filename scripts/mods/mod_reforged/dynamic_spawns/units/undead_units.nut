// This Combines Units from spawnlist_zombies and spawnlist_undead
local units = [
// Zombies
	{
		ID = "Unit.UndeadZombie",
		Troop = "Zombie",
		Figure = "figure_zombie_01",       // Exclusiv
		Cost = 6
	},
	{
		ID = "Unit.UndeadZombieYeoman",
		Troop = "ZombieYeoman",
		Figure = "figure_zombie_02",
		Cost = 12
	},
	{
		ID = "Unit.UndeadZombieNomad",
		Troop = "ZombieNomad",
		Figure = "figure_zombie_03",
		Cost = 12
	},
	{
		ID = "Unit.UndeadFallenHero",     // Fallen Hero
		Troop = "ZombieKnight",
		Figure = "figure_zombie_03",
		Cost = 24
	},
	{
		ID = "Unit.UndeadNecromancer",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],    // In Vanilla 02 is only used for Scourge Spawns. But there they still use 01 randomly aswell
		Cost = 30
	},

// Necromancer with Bodyguards
	{
		ID = "Unit.UndeadNecromancerY",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12,
		SubPartyDef = {ID = "SubPartyYeoman"}
	},
	{
		ID = "Unit.UndeadNecromancerK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 24,
		SubPartyDef = {ID = "SubPartyKnight"}
	},
	{
		ID = "Unit.UndeadNecromancerYK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 24,
		SubPartyDef = {ID = "SubPartyYeomanKnight"}
	},
	{
		ID = "Unit.UndeadNecromancerKK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 24 + 24,
		SubPartyDef = {ID = "SubPartyKnightKnight"}
	},

// Necromancer with Nomad Bodyguards
	{
		ID = "Unit.UndeadNecromancerN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 1, HardMax = 1 }
	},
	{
		ID = "Unit.UndeadNecromancerNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 2, HardMax = 2 }
	},
	{
		ID = "Unit.UndeadNecromancerNNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 3, HardMax = 3 }
	}

// Bodyguards for Necromancer
	{
		ID = "Unit.UndeadYeomanBodyguard",
		Troop = "ZombieYeomanBodyguard",
		Figure = "figure_zombie_02",
		Cost = 12
	},
	{
		ID = "Unit.UndeadZombieNomadBodyguard",
		Troop = "ZombieNomadBodyguard",
		Figure = "figure_zombie_03",
		Cost = 12
	},
	{
		ID = "Unit.UndeadFallenHeroBodyguard",
		Troop = "ZombieKnightBodyguard",
		Figure = "figure_zombie_03",
		Cost = 24
	},

// Ghosts
	{
		ID = "Unit.UndeadGhost",
		Troop = "Ghost",
		Figure = "figure_ghost_01",     // Exclusiv
		Cost = 20
	},

// Skeletons
	{
		ID = "Unit.UndeadSkeletonLight",
		Troop = "SkeletonLight",
		Figure = "figure_skeleton_01",      // Exclusiv
		Cost = 13
	},
	{
		ID = "Unit.UndeadSkeletonMedium",
		Troop = "SkeletonMedium",
		Figure = "figure_skeleton_02",
		Cost = 20
	},
	{
		ID = "Unit.UndeadSkeletonMediumPolearm",
		Troop = "SkeletonMediumPolearm",
		Figure = "figure_skeleton_02",
		Cost = 25
	},
	{
		ID = "Unit.UndeadSkeletonHeavy",
		Troop = "SkeletonHeavy",
		Figure = "figure_skeleton_03",
		Cost = 35
	},
	{
		ID = "Unit.UndeadSkeletonHeavyPolearm",
		Troop = "SkeletonHeavyPolearm",
		Figure = "figure_skeleton_03",
		Cost = 35
	},
	{
		ID = "Unit.UndeadSkeletonPriest",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40
	},
	{
		ID = "Unit.UndeadSkeletonPriestH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40 + 30,
		SubPartyDef = {ID = "SubPartyHonor"}
	},
	{
		ID = "Unit.UndeadSkeletonPriestHH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40 + 30 + 30,
		SubPartyDef = {ID = "SubPartyHonorHonor"}
	},

// Bodyguards for Priests
	{
		ID = "Unit.UndeadSkeletonHeavyBodyguard",
		Troop = "SkeletonHeavyBodyguard",
		Figure = "figure_zombie_03",
		Cost = 30
	},

// Vampire
	{
		ID = "Unit.UndeadVampireLOW",
		Troop = "VampireLOW",
		Figure = "figure_vampire_01",       // Exclusiv
		Cost = 30
	},
	{
		ID = "Unit.UndeadVampire",
		Troop = "Vampire",
		Figure = "figure_vampire_02",       // Exclusiv
		Cost = 40
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
