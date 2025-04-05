local unitBlocks = [
	{
		ID = "UnitBlock.RF.ZombieFrontline",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Zombie" }, { BaseID = "Unit.RF.ZombieYeoman" }, { BaseID = "Unit.RF.ZombieKnight", RatioMax = 0.5 }]
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
			Units = [{ BaseID = "Unit.RF.ZombieKnight" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieSouthern",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieNomad" }]
		}
	},
	{
		ID = "UnitBlock.RF.Necromancer",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Necromancer" }]
		}
	},
	{
		ID = "UnitBlock.RF.NecromancerWithBodyguards",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.NecromancerY" },
				{ BaseID = "Unit.RF.NecromancerK" },
				{ BaseID = "Unit.RF.NecromancerYK" },
				{ BaseID = "Unit.RF.NecromancerKK" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.NecromancerWithNomads",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.NecromancerN" },
				{ BaseID = "Unit.RF.NecromancerNN" },
				{ BaseID = "Unit.RF.NecromancerNNN" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.Ghost",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.Ghost" }]
		}
	},
	{
		ID = "UnitBlock.RF.ZombieNomadBodyguard",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.ZombieNomadBodyguard" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
