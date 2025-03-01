local unitBlocks = [
	{
		ID = "UnitBlock.RF.ZombieFrontline",
		UnitDefs = [{ BaseID = "Unit.RF.Zombie" }, { BaseID = "Unit.RF.ZombieYeoman" }, { BaseID = "Unit.RF.ZombieKnight", RatioMax = 0.5 }]
	},
	{
		ID = "UnitBlock.RF.ZombieLight",
		UnitDefs = [{ BaseID = "Unit.RF.Zombie" }]
	},
	{
		ID = "UnitBlock.RF.ZombieElite",
		UnitDefs = [{ BaseID = "Unit.RF.ZombieKnight" }]
	},
	{
		ID = "UnitBlock.RF.ZombieSouthern",
		UnitDefs = [{ BaseID = "Unit.RF.ZombieNomad" }]
	},
	{
		ID = "UnitBlock.RF.Necromancer",
		UnitDefs = [{ BaseID = "Unit.RF.Necromancer" }]
	},
	{
		ID = "UnitBlock.RF.NecromancerWithBodyguards",
		UnitDefs = [
			{ BaseID = "Unit.RF.NecromancerY" },
			{ BaseID = "Unit.RF.NecromancerK" },
			{ BaseID = "Unit.RF.NecromancerYK" },
			{ BaseID = "Unit.RF.NecromancerKK" }
		]
	},
	{
		ID = "UnitBlock.RF.NecromancerWithNomads",
		UnitDefs = [
			{ BaseID = "Unit.RF.NecromancerN" },
			{ BaseID = "Unit.RF.NecromancerNN" },
			{ BaseID = "Unit.RF.NecromancerNNN" }
		]
	},
	{
		ID = "UnitBlock.RF.Ghost",
		UnitDefs = [{ BaseID = "Unit.RF.Ghost" }]
	},
	{
		ID = "UnitBlock.RF.ZombieNomadBodyguard",
		UnitDefs = [
			{ BaseID = "Unit.RF.ZombieNomadBodyguard" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
