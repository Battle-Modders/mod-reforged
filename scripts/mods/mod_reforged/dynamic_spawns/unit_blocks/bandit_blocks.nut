local unitBlocks = [
	// {
	// ID = "UnitBlock.BanditFrontline",
	// 	UnitDefs = [
	// 		{ID = "UnitBlock.BanditScoundrel" },
	// 		{ID = "UnitBlock.BanditThug" },
	// 		{ID = "UnitBlock.BanditRobber" },
	// 		{ID = "UnitBlock.BanditRobberThrower" },
	// 		{ID = "UnitBlock.BanditVandal" },
	// 		{ID = "UnitBlock.BanditPillager" },
	// 		{ID = "UnitBlock.BanditPillagerShield" },
	// 		{ID = "UnitBlock.BanditRaider" },
	// 		{ID = "UnitBlock.BanditOutlaw" },
	// 		{ID = "UnitBlock.BanditBandit" },
	// 		{ID = "UnitBlock.BanditBanditThrower" },
	// 		{ID = "UnitBlock.BanditHighwayman" },
	// 		{ID = "UnitBlock.BanditMarauder" },
	// 		{ID = "UnitBlock.BanditKiller" },
	// 		{ID = "UnitBlock.BanditKillerThrower" }
	// 	]
	// },
	{
		ID = "UnitBlock.BanditBalanced",
		UnitDefs = [
			{BaseID = "Unit.RF_BanditScoundrel",  StartingResourceMax = 250 },
			{BaseID = "Unit.RF_BanditVandal", StartingResourceMin = 150 },
			{BaseID = "Unit.BanditRaider", StartingResourceMin = 200 },
			{BaseID = "Unit.RF_BanditHighwayman", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.BanditFast",
		UnitDefs = [
			{BaseID = "Unit.RF_BanditRobber", StartingResourceMin = 125 },
			{BaseID = "Unit.RF_BanditBandit", StartingResourceMin = 200 },
			{BaseID = "Unit.RF_BanditKiller", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.BanditTough",
		UnitDefs = [
			{BaseID = "Unit.BanditThug", StartingResourceMin = 63, StartingResourceMax = 275 },
			{BaseID = "Unit.RF_BanditPillager", StartingResourceMin = 150 },
			{BaseID = "Unit.RF_BanditOutlaw", StartingResourceMin = 200 },
			{BaseID = "Unit.RF_BanditMarauder", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.BanditRanged",
		UnitDefs = [
			{BaseID = "Unit.BanditPoacher", StartingResourceMax = 250 },
			{BaseID = "Unit.RF_BanditHunter", StartingResourceMin = 125 },
			{BaseID = "Unit.BanditMarksman", StartingResourceMin = 200 },
			{BaseID = "Unit.RF_BanditSharpshooter", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.BanditDog",
		UnitDefs = [
			{BaseID = "Unit.BanditWardog", StartingResourceMax = 250 }
		]
	},
	{
		ID = "UnitBlock.BanditElite",
		StartingResourceMin = 350,
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, {BaseID = "Unit.HumanMasterArcher" }],
			[1, {BaseID = "Unit.HumanHedgeKnight" }],
			[1, {BaseID = "Unit.HumanSwordmaster" }]
		])
	},
	{
		ID = "UnitBlock.BanditBoss",
		UnitDefs = [
			{BaseID = "Unit.BanditLeader", StartingResourceMin = 250 },
			{BaseID = "Unit.RF_BanditBaron" }
		]
	},
	{
		ID = "UnitBlock.BanditDisguisedDirewolf",
		UnitDefs = [{BaseID = "Unit.BanditRaiderWolf" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
