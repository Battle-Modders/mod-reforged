local units = [
// Zombies
	{
		ID = "Unit.RF.Zombie",
		Troop = "Zombie",
		Figure = "figure_zombie_01"       // Exclusive
	},
	{
		ID = "Unit.RF.ZombieYeoman",
		Troop = "ZombieYeoman",
		Figure = "figure_zombie_02",
		StartingResourceMin = 75
	},
	{
		ID = "Unit.RF.ZombieNomad",
		Troop = "ZombieNomad",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.RF.ZombieKnight",     // Fallen Hero
		Troop = "ZombieKnight",
		Figure = "figure_zombie_03",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.RF.Necromancer",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"]    // In Vanilla 02 is only used for Scourge Spawns. But there they still use 01 randomly aswell
	},

// Necromancer with Bodyguards
	{
		ID = "Unit.RF.NecromancerY",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 100,
		Cost = 30 + 12,
		SubPartyDef = {ID = "SubPartyYeoman"}
	},
	{
		ID = "Unit.RF.NecromancerK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 320,
		Cost = 30 + 24,
		SubPartyDef = {ID = "SubPartyKnight"}
	},
	{
		ID = "Unit.RF.NecromancerYK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 360,
		Cost = 30 + 12 + 24,
		SubPartyDef = {ID = "SubPartyYeomanKnight"}
	},
	{
		ID = "Unit.RF.NecromancerKK",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 420,
		Cost = 30 + 24 + 24,
		SubPartyDef = {ID = "SubPartyKnightKnight"}
	},

// Necromancer with Nomad Bodyguards
	{
		ID = "Unit.RF.NecromancerN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 110,
		Cost = 30 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 1, HardMax = 1 }
	},
	{
		ID = "Unit.RF.NecromancerNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 130,
		Cost = 30 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 2, HardMax = 2 }
	},
	{
		ID = "Unit.RF.NecromancerNNN",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 170,
		Cost = 30 + 12 + 12 + 12,
		SubPartyDef = { BaseID = "SubPartyNomad", HardMin = 3, HardMax = 3 }
	}

// Bodyguards for Necromancer
	{
		ID = "Unit.RF.ZombieYeomanBodyguard",
		Troop = "ZombieYeomanBodyguard",
		Figure = "figure_zombie_02"
	},
	{
		ID = "Unit.RF.ZombieNomadBodyguard",
		Troop = "ZombieNomadBodyguard",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.RF.ZombieKnightBodyguard",
		Troop = "ZombieKnightBodyguard",
		Figure = "figure_zombie_03"
	},

// Ghosts
	{
		ID = "Unit.RF.Ghost",
		Troop = "Ghost",
		Figure = "figure_ghost_01"     // Exclusive
	},
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
