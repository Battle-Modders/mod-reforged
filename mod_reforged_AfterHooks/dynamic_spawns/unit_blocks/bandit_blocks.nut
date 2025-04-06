local unitBlocks = [
	{
		ID = "UnitBlock.RF.BanditBalanced",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_BanditScoundrel" },
				{ BaseID = "Unit.RF.RF_BanditVandal" },
				{ BaseID = "Unit.RF.BanditRaider" },
				{ BaseID = "Unit.RF.RF_BanditHighwayman" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditFast",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.RF_BanditRobber" }, // added for balanced spawns and upgrading compared to Balanced, Tough and Ranged
				{ BaseID = "Unit.RF.RF_BanditRobber" },
				{ BaseID = "Unit.RF.RF_BanditBandit" },
				{ BaseID = "Unit.RF.RF_BanditKiller" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditTough",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.BanditThug" },
				{ BaseID = "Unit.RF.RF_BanditPillager" },
				{ BaseID = "Unit.RF.RF_BanditOutlaw" },
				{ BaseID = "Unit.RF.RF_BanditMarauder" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditRanged",
		TierWidth = 2,
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.BanditMarksmanLOW" },
				{ BaseID = "Unit.RF.RF_BanditHunter" },
				{ BaseID = "Unit.RF.BanditMarksman" },
				{ BaseID = "Unit.RF.RF_BanditSharpshooter" }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditDog",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.Wardog" },
				{ BaseID = "Unit.RF.ArmoredWardog", StartingResourceMin = 125 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditElite",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.MasterArcher" }],
				[1, { BaseID = "Unit.RF.HedgeKnight" }],
				[1, { BaseID = "Unit.RF.Swordmaster" }]
			])
		}
	},
	{
		ID = "UnitBlock.RF.BanditBoss",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.BanditLeader" },
				{ BaseID = "Unit.RF.RF_BanditBaron", HardMax = 1 }
			]
		}
	},
	{
		ID = "UnitBlock.RF.BanditDisguisedDirewolf",
		DynamicDefs = {
			Units = [{ BaseID = "Unit.RF.BanditRaiderWolf" }]
		}
	}
]

foreach (blockDef in unitBlocks)
{
	::DynamicSpawns.Public.registerUnitBlock(blockDef);
}
