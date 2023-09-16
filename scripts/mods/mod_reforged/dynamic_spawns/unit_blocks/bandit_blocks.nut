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
			{ ID = "Unit.RF_BanditVandal", StartingResourceMin = 150 },
			{ ID = "Bandit.Raider", StartingResourceMin = 200 },
			{ ID = "Unit.RF_BanditHighwayman", StartingResourceMin = 300 }
		]
	},
	{
		ID = "Bandit.Fast",
		UnitDefs = [
			{ ID = "Unit.RF_BanditRobber", StartingResourceMin = 125 },
			{ ID = "Unit.RF_BanditBandit", StartingResourceMin = 200 },
			{ ID = "Unit.RF_BanditKiller", StartingResourceMin = 300 }
		]
	},
	{
		ID = "Bandit.Tough",
		UnitDefs = [
			{ ID = "Bandit.Thug", StartingResourceMin = 63, StartingResourceMax = 275 },
			{ ID = "Unit.RF_BanditPillager", StartingResourceMin = 150 },
			{ ID = "Unit.RF_BanditOutlaw", StartingResourceMin = 200 },
			{ ID = "Unit.RF_BanditMarauder", StartingResourceMin = 300 }
		]
	},
	{
		ID = "Bandit.Ranged",
		UnitDefs = [
			{ ID = "Bandit.Poacher", StartingResourceMax = 250 },
			{ ID = "Unit.RF_BanditHunter", StartingResourceMin = 125 },
			{ ID = "Bandit.Marksman", StartingResourceMin = 200 },
			{ ID = "Unit.RF_BanditSharpshooter", StartingResourceMin = 300 }
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
			{ ID = "Bandit.Leader", StartingResourceMin = 250 },
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
