local unitBlocks = [
	{
			ID = "UnitBlock.ZombieFrontline",
		UnitDefs = [{ BaseID = "Unit.Zombie" }, { BaseID = "Unit.ZombieYeoman" }, { BaseID = "Unit.FallenHero" }]
	},
	{
			ID = "UnitBlock.ZombieLight",
		UnitDefs = [{ BaseID = "Unit.Zombie" }]
	},
	{
			ID = "UnitBlock.ZombieElite",
		UnitDefs = [{ BaseID = "Unit.FallenHero" }]
	},
	{
			ID = "UnitBlock.ZombieSouthern",
		UnitDefs = [{ BaseID = "Unit.ZombieNomad" }]
	},
	{
			ID = "UnitBlock.Necromancer",
		UnitDefs = [{ BaseID = "Unit.Necromancer" }]
	},
	{
			ID = "UnitBlock.NecromancerWithBodyguards",
		UnitDefs = [
			{ BaseID = "Unit.NecromancerY" },
			{ BaseID = "Unit.NecromancerK" },
			{ BaseID = "Unit.NecromancerYK" },
			{ BaseID = "Unit.NecromancerKK" }
		]
	},
	{
			ID = "UnitBlock.NecromancerWithNomads",
		UnitDefs = [
			{ BaseID = "Unit.NecromancerN" },
			{ BaseID = "Unit.NecromancerNN" },
			{ BaseID = "Unit.NecromancerNNN" }
		]
	},
	{
			ID = "UnitBlock.Ghost",
		UnitDefs = [{ BaseID = "Unit.Ghost" }]
	},
	{
			ID = "UnitBlock.ZombieNomadBodyguard",
		UnitDefs = [
			{ BaseID = "Unit.ZombieNomadBodyguard" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
