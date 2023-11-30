local unitBlocks = [
	{
		ID = "UnitBlock.RF.BanditBalanced",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditScoundrel" },
			{ BaseID = "Unit.RF.RF_BanditVandal" },
			{ BaseID = "Unit.RF.BanditRaider" },
			{ BaseID = "Unit.RF.RF_BanditHighwayman" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditFast",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.RF_BanditRobber" }, // added for balanced spawns and upgrading compared to Balanced, Tough and Ranged
			{ BaseID = "Unit.RF.RF_BanditRobber" },
			{ BaseID = "Unit.RF.RF_BanditBandit" },
			{ BaseID = "Unit.RF.RF_BanditKiller" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditTough",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditThug" },
			{ BaseID = "Unit.RF.RF_BanditPillager" },
			{ BaseID = "Unit.RF.RF_BanditOutlaw" },
			{ BaseID = "Unit.RF.RF_BanditMarauder" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditRanged",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditMarksmanLOW" },
			{ BaseID = "Unit.RF.RF_BanditHunter" },
			{ BaseID = "Unit.RF.BanditMarksman" },
			{ BaseID = "Unit.RF.RF_BanditSharpshooter" }
		]
	},
	{
		ID = "UnitBlock.RF.BanditDog",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.Wardog" },
			{ BaseID = "Unit.RF.ArmoredWardog", StartingResourceMin = 125 }
		]
	},
	{
		ID = "UnitBlock.RF.BanditElite",
		DeterminesFigure = true,
		UnitDefs = ::MSU.Class.WeightedContainer([
			[1, { BaseID = "Unit.RF.MasterArcher" }],
			[1, { BaseID = "Unit.RF.HedgeKnight" }],
			[1, { BaseID = "Unit.RF.Swordmaster" }]
		])
	},
	{
		ID = "UnitBlock.RF.BanditBoss",
		DeterminesFigure = true,
		UnitDefs = [
			{ BaseID = "Unit.RF.BanditLeader" },
			{ BaseID = "Unit.RF.RF_BanditBaron", HardMax = 1 }
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
