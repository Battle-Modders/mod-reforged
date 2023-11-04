local unitBlocks = [
	{
		ID = "UnitBlock.RF.BanditBalanced",
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditScoundrel",  StartingResourceMax = 250 },
			{ BaseID = "Unit.RF.RF_BanditVandal", StartingResourceMin = 150 },
			{ BaseID = "Unit.RF.BanditRaider", StartingResourceMin = 200 },
			{ BaseID = "Unit.RF.RF_BanditHighwayman", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditFast",
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditRobber", StartingResourceMin = 125 },
			{ BaseID = "Unit.RF.RF_BanditBandit", StartingResourceMin = 200 },
			{ BaseID = "Unit.RF.RF_BanditKiller", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditTough",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditThug", StartingResourceMin = 63, StartingResourceMax = 275 },
			{ BaseID = "Unit.RF.RF_BanditPillager", StartingResourceMin = 150 },
			{ BaseID = "Unit.RF.RF_BanditOutlaw", StartingResourceMin = 200 },
			{ BaseID = "Unit.RF.RF_BanditMarauder", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditRanged",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditPoacher", StartingResourceMax = 250 },
			{ BaseID = "Unit.RF.RF_BanditHunter", StartingResourceMin = 125 },
			{ BaseID = "Unit.RF.BanditMarksman", StartingResourceMin = 200 },
			{ BaseID = "Unit.RF.RF_BanditSharpshooter", StartingResourceMin = 300 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditDog",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditWardog", StartingResourceMax = 250 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditElite",
		StartingResourceMin = 350,
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.HumanMasterArcher" }],
			[1, { BaseID = "Unit.RF.HumanHedgeKnight" }],
			[1, { BaseID = "Unit.RF.HumanSwordmaster" }]
		])
	},
	{
		ID = "UnitBlock.RF.BanditBoss",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditLeader", StartingResourceMin = 250 },
			{ BaseID = "Unit.RF.RF_BanditBaron" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditDisguisedDirewolf",
		UnitDefs = [{ BaseID = "Unit.RF.BanditRaiderWolf" }]
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
