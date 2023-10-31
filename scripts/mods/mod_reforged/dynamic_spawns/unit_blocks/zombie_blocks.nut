local unitBlocks = [
	{
			ID = "UnitBlock.ZombieFrontline",
		UnitDefs = [{ BaseID = "Unit.UndeadZombie" }, { BaseID = "Unit.UndeadZombieYeoman" }, { BaseID = "Unit.UndeadFallenHero" }]
	},
	{
			ID = "UnitBlock.ZombieLight",
		UnitDefs = [{ BaseID = "Unit.UndeadZombie" }]
	},
	{
			ID = "UnitBlock.ZombieElite",
		UnitDefs = [{ BaseID = "Unit.UndeadFallenHero" }]
	},
	{
			ID = "UnitBlock.ZombieSouthern",
		UnitDefs = [{ BaseID = "Unit.UndeadZombieNomad" }]
	},
	{
			ID = "UnitBlock.ZombieNecromancer",
		UnitDefs = [{ BaseID = "Unit.UndeadNecromancer" }]
	},
	{
			ID = "UnitBlock.ZombieNecromancerWithBodyguards",
		UnitDefs = [
			{ BaseID = "Unit.UndeadNecromancerY" },
			{ BaseID = "Unit.UndeadNecromancerK" },
			{ BaseID = "Unit.UndeadNecromancerYK" },
			{ BaseID = "Unit.UndeadNecromancerKK" }
		]
	},
	{
			ID = "UnitBlock.ZombieNecromancerWithNomads",
		UnitDefs = [
			{ BaseID = "Unit.UndeadNecromancerN" },
			{ BaseID = "Unit.UndeadNecromancerNN" },
			{ BaseID = "Unit.UndeadNecromancerNNN" }
		]
	},
	{
			ID = "UnitBlock.ZombieGhost",
		UnitDefs = [{ BaseID = "Unit.UndeadGhost" }]
	},
	{
			ID = "UnitBlock.ZombieZombieNomadBodyguard",
		UnitDefs = [
			{ BaseID = "Unit.UndeadZombieNomadBodyguard" }
		]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
