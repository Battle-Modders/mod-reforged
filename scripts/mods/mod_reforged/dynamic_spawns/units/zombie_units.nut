local units = [
// Zombies
	{
		ID = "Unit.Zombie",
		Troop = "Zombie",
		Figure = "figure_zombie_01"       // Exclusiv
	},
	{
		ID = "Unit.ZombieYeoman",
		Troop = "ZombieYeoman",
		Figure = "figure_zombie_02",
		StartingResourceMin = 75
	},
	{
		ID = "Unit.ZombieNomad",
		Troop = "ZombieNomad",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.FallenHero",     // Fallen Hero
		Troop = "ZombieKnight",
		Figure = "figure_zombie_03",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.Necromancer",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"]    // In Vanilla 02 is only used for Scourge Spawns. But there they still use 01 randomly aswell
	},

// Necromancer with Bodyguards
	{
		ID = "Unit.NecromancerY",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12,
		SubPartyDef = {ID = "SubPartyYeoman"}
	},
	{
		ID = "Unit.NecromancerK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 24,
		SubPartyDef = {ID = "SubPartyKnight"}
	},
	{
		ID = "Unit.NecromancerYK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 24,
		SubPartyDef = {ID = "SubPartyYeomanKnight"}
	},
	{
		ID = "Unit.NecromancerKK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 24 + 24,
		SubPartyDef = {ID = "SubPartyKnightKnight"}
	},

// Necromancer with Nomad Bodyguards
	{
		ID = "Unit.NecromancerN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 1, HardMax = 1 }
	},
	{
		ID = "Unit.NecromancerNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 2, HardMax = 2 }
	},
	{
		ID = "Unit.NecromancerNNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 30 + 12 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 3, HardMax = 3 }
	}

// Bodyguards for Necromancer
	{
		ID = "Unit.YeomanBodyguard",
		Troop = "ZombieYeomanBodyguard",
		Figure = "figure_zombie_02"
	},
	{
		ID = "Unit.ZombieNomadBodyguard",
		Troop = "ZombieNomadBodyguard",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.FallenHeroBodyguard",
		Troop = "ZombieKnightBodyguard",
		Figure = "figure_zombie_03"
	},

// Ghosts
	{
		ID = "Unit.Ghost",
		Troop = "Ghost",
		Figure = "figure_ghost_01"     // Exclusiv
	},
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
