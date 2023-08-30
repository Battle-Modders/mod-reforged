local unitBlocks = [
	// {
	// 	ID = "Bandit.Frontline",
	// 	UnitDefs = [
	// 		{ ID = "Bandit.Scoundrel" },
	// 		{ ID = "Bandit.Thug" },
	// 		{ ID = "Bandit.Robber" },
	// 		{ ID = "Bandit.RobberThrower" },
	// 		{ ID = "Bandit.Vandal" },
	// 		{ ID = "Bandit.Pillager" },
	// 		{ ID = "Bandit.PillagerShield" },
	// 		{ ID = "Bandit.Raider" },
	// 		{ ID = "Bandit.Outlaw" },
	// 		{ ID = "Bandit.Bandit" },
	// 		{ ID = "Bandit.BanditThrower" },
	// 		{ ID = "Bandit.Highwayman" },
	// 		{ ID = "Bandit.Marauder" },
	// 		{ ID = "Bandit.Killer" },
	// 		{ ID = "Bandit.KillerThrower" }
	// 	]
	// },
	{
		ID = "Bandit.Balanced",
		UnitDefs = [
			{ ID = "Unit.RF_BanditScoundrel",  StartingResourceMax = 250 },
			{ ID = "Unit.RF_BanditVandal" },
			{ ID = "Bandit.Raider" },
			{ ID = "Unit.RF_BanditHighwayman", StartingResourceMin = 250 }
		]
	},
	{
		ID = "Bandit.Fast",
		UnitDefs = [
			{ ID = "Unit.RF_BanditRobber" },
			{ ID = "Unit.RF_BanditBandit" },
			{ ID = "Unit.RF_BanditKiller", StartingResourceMin = 250 }
		]
	},
	{
		ID = "Bandit.Tough",
		UnitDefs = [
			{ ID = "Bandit.Thug", StartingResourceMax = 275 },
			{ ID = "Unit.RF_BanditPillager" },
			{ ID = "Unit.RF_BanditOutlaw" },
			{ ID = "Unit.RF_BanditMarauder", StartingResourceMin = 250 }
		]
	},
	{
		ID = "Bandit.Ranged",
		UnitDefs = [
			{ ID = "Bandit.Poacher", StartingResourceMax = 250 },
			{ ID = "Unit.RF_BanditHunter" },
			{ ID = "Bandit.Marksman" },
			{ ID = "Unit.RF_BanditSharpshooter", StartingResourceMin = 250 }
		]
	},
	{
		ID = "Bandit.Dogs",
		UnitDefs = [
			{ ID = "Bandit.Wardog", StartingResourceMax = 250 }
		]
	},
	{
		ID = "Bandit.Elite",
		StartingResourceMin = 350,
		IsRandom = true,
		UnitDefs = [
			{ ID = "Human.MasterArcher" },
			{ ID = "Human.HedgeKnight" },
			{ ID = "Human.Swordmaster" }
		]
	},
	{
		ID = "Bandit.Boss",
		UnitDefs = [
			{ ID = "Bandit.Leader" },
			{ ID = "Unit.RF_BanditBaron" }
		]
	},
	{
		ID = "Bandit.DisguisedDirewolf",
		UnitDefs = [{ ID = "Bandit.RaiderWolf" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
