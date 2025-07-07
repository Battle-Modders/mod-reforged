local unitBlocks = [
	// Zombies Human
	{
		ID = "UnitBlock.RF.ZombieFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Zombie", RatioMin = 0.05 }, { BaseID = "Unit.RF.ZombieYeoman" }, { BaseID = "Unit.RF.ZombieKnight", RatioMax = 0.3 },
			{ BaseID = "Unit.RF.RF_ZombieHero",
				function onBeforeSpawnStart()
				{
					this.RatioMax = ::MSU.Math.randf(0.2, 0.35);
				}
			}]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieFrontlineSouthern",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieNomad", RatioMin = 0.20 }, { BaseID = "Unit.RF.ZombieKnight", RatioMax = 0.3 },
			{ BaseID = "Unit.RF.RF_ZombieHero",
				function onBeforeSpawnStart()
				{
					this.RatioMax = ::MSU.Math.randf(0.2, 0.35);
				}
			}]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieLight",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Zombie" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieElite",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieKnight" }, { BaseID = "Unit.RF.RF_ZombieHero" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieSouthern",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieNomad" }]
		}
	},

	// Zombie Orcs
	{
		ID = "UnitBlock.RF.ZombieOrcYoung",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_ZombieOrcYoung" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieOrcBerserker",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_ZombieOrcBerserker" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieOrcWarrior",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_ZombieOrcWarrior" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieOrcWarlord",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_ZombieOrcWarlord", HardMax = 1 }]
		}
	},

	// Necromancer
	{
		ID = "UnitBlock.RF.Necromancer",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Necromancer" }]
		}
	},

	// Necromancer with Bodyguards
	{
		ID = "UnitBlock.RF.NecromancerWithBodyguards",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.NecromancerWithBodyguards" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.NecromancerWithBodyguardsNomad",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.NecromancerWithBodyguardsNomad" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.NecromancerWithBodyguardsOrc",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.NecromancerWithBodyguardsOrc" }
			]
		}
	},

	// Bodyguards
	{
		ID = "UnitBlock.RF.ZombieBodyguard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieBodyguard", StartingResourceMax = 150 }, { BaseID = "Unit.RF.ZombieYeomanBodyguard", StartingResourceMax = 250 }, { BaseID = "Unit.RF.ZombieKnightBodyguard" }, { BaseID = "Unit.RF.RF_ZombieHeroBodyguard" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieBodyguardNomad",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieNomadBodyguard" }, { BaseID = "Unit.RF.ZombieKnightBodyguard" }, { BaseID = "Unit.RF.RF_ZombieHeroBodyguard" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieBodyguardOrc",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_ZombieOrcYoungBodyguard" }, { BaseID = "Unit.RF.RF_ZombieOrcWarriorBodyguard" }]
		}
	},

	// Other
	{
		ID = "UnitBlock.RF.Ghost",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Ghost" }]
		}
	},
	{
		ID = "UnitBlock.RF.Hollenhund",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_Hollenhund", HardMax = 3 }]
		}
	},
	{
		ID = "UnitBlock.RF.Banshee",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.RF_Banshee", HardMax = 1 }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
