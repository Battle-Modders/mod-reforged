local units = [
// Zombies Human
	{
		ID = "Unit.RF.Zombie",
		Troop = "Zombie",
		Figure = "figure_zombie_01"		// Exclusive
	},
	{
		ID = "Unit.RF.ZombieYeoman",
		Troop = "ZombieYeoman",
		Figure = "figure_zombie_02",
		StartingResourceMin = 50 // Vanilla is 48 in "Zombies" party
	},
	{
		ID = "Unit.RF.ZombieKnight",	 // Fallen Hero
		Troop = "ZombieKnight",
		Figure = "figure_zombie_03",
		StartingResourceMin = 115 // Vanilla is 114 in "Zombies" party
	},
	{
		ID = "Unit.RF.RF_ZombieHero",
		Troop = "RF_ZombieHero",
		Figure = "figure_zombie_03",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.RF.ZombieNomad",
		Troop = "ZombieNomad",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.RF.Necromancer",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"]	// In Vanilla 02 is only used for Scourge Spawns. But there they still use 01 randomly aswell
	},

	// Zombie Orcs
	{
		ID = "Unit.RF.RF_ZombieOrcYoung",
		Troop = "RF_ZombieOrcYoung",
		// Figure = "figure_rf_skeleton_light_elite"
	},
	{
		ID = "Unit.RF.RF_ZombieOrcWarrior",
		Troop = "RF_ZombieOrcWarrior",
		// Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.RF_ZombieOrcBerserker",
		Troop = "RF_ZombieOrcBerserker",
		// Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 175
	},
	{
		ID = "Unit.RF.RF_ZombieOrcWarlord",
		Troop = "RF_ZombieOrcWarlord",
		// Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 275
	},

// Necromancers with Bodyguards
	{
		ID = "Unit.RF.NecromancerWithBodyguards",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 100, // In Vanilla they appear in a group of 102 cost
		Cost = 30,
		StaticDefs = {
			Parties = [
				{ BaseID = "NecromancerBodyguards", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.NecromancerWithBodyguardsNomad",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 100, // In Vanilla they appear in a group of 102 cost
		Cost = 30,
		StaticDefs = {
			Parties = [
				{ BaseID = "NecromancerBodyguardsNomad", IsUsingTopPartyResources = false }
			]
		}
	},
	{
		ID = "Unit.RF.NecromancerWithBodyguardsOrc",
		Troop = "Necromancer",
		Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		StartingResourceMin = 100, // In Vanilla they appear in a group of 102 cost
		Cost = 30,
		StaticDefs = {
			Parties = [
				{ BaseID = "NecromancerBodyguardsOrc", IsUsingTopPartyResources = false }
			]
		}
	},

// Bodyguards for Necromancer
	{
		ID = "Unit.RF.ZombieBodyguard",
		Troop = "ZombieBodyguard",
		Figure = "figure_zombie_02"
	},
	{
		ID = "Unit.RF.ZombieYeomanBodyguard",
		Troop = "ZombieYeomanBodyguard",
		Figure = "figure_zombie_02"
	},
	{
		ID = "Unit.RF.ZombieKnightBodyguard",
		Troop = "ZombieKnightBodyguard",
		Figure = "figure_zombie_03",
		StartingResourceMin = 175
	},
	{
		ID = "Unit.RF.RF_ZombieHeroBodyguard",
		Troop = "RF_ZombieHeroBodyguard",
		Figure = "figure_zombie_03",
		StartingResourceMin = 250
	},
	{
		ID = "Unit.RF.ZombieNomadBodyguard",
		Troop = "ZombieNomadBodyguard",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.RF.RF_ZombieOrcYoungBodyguard",
		Troop = "RF_ZombieOrcYoungBodyguard",
		Figure = "figure_zombie_03"
	},
	{
		ID = "Unit.RF.RF_ZombieOrcWarriorBodyguard",
		Troop = "RF_ZombieOrcWarriorBodyguard",
		Figure = "figure_zombie_03",
		StartingResourceMin = 150
	},

// Other
	{
		ID = "Unit.RF.Ghost",
		Troop = "Ghost",
		Figure = "figure_ghost_01"	 // Exclusive
	},
	{
		ID = "Unit.RF.RF_Hollenhund",
		Troop = "RF_Hollenhund",
		// Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 200
	},
	{
		ID = "Unit.RF.RF_Banshee",
		Troop = "RF_Banshee",
		// Figure = "figure_rf_skeleton_light_elite",
		StartingResourceMin = 300
	}
];

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
}
