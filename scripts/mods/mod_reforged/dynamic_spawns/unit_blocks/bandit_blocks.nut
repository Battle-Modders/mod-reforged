local unitBlocks = [
	{
		ID = "UnitBlock.RF.BanditBalanced",
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditScoundrel" },
			{ BaseID = "Unit.RF.RF_BanditVandal" },
			{ BaseID = "Unit.RF.BanditRaider" },
			{ BaseID = "Unit.RF.RF_BanditHighwayman" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditFast",
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditRobber" },
			{ BaseID = "Unit.RF.RF_BanditBandit" },
			{ BaseID = "Unit.RF.RF_BanditKiller" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditTough",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditThug" },
			{ BaseID = "Unit.RF.RF_BanditPillager" },
			{ BaseID = "Unit.RF.RF_BanditOutlaw" },
			{ BaseID = "Unit.RF.RF_BanditMarauder" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditRanged",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditPoacher" },
			{ BaseID = "Unit.RF.RF_BanditHunter" },
			{ BaseID = "Unit.RF.BanditMarksman" },
			{ BaseID = "Unit.RF.RF_BanditSharpshooter" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditDog",
		UnitDefs = [
			{ BaseID = "Unit.RF.Wardog" },
			{ BaseID = "Unit.RF.ArmoredWardog" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditElite",
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.HumanMasterArcher" }],
			[1, { BaseID = "Unit.RF.HumanHedgeKnight" }],
			[1, { BaseID = "Unit.RF.HumanSwordmaster" }]
		])
	},
	{
		ID = "UnitBlock.RF.BanditBoss",
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditLeader" },
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
