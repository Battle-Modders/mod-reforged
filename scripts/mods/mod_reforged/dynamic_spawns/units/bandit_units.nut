local units = [
	{
		ID = "Unit.RF.BanditThug",
		Troop = "BanditThug",
		Figure = "figure_rf_bandit_thug",
		StartingResourceMin = 63 // 7 Scoundrels worth or resource
	},
	{
		ID = "Unit.RF.Wardog",
		Troop = "Wardog",
	},
	{
		ID = "Unit.RF.BanditMarksmanLOW",
		Troop = "BanditMarksmanLOW",
		Figure = "figure_bandit_01", // Vanilla bandit poacher figure
	},
	{
		ID = "Unit.RF.BanditMarksman",
		Troop = "BanditMarksman",
		Figure = "figure_rf_bandit_marksman"
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.BanditRaider",
		Troop = "BanditRaider",
		Figure = "figure_rf_bandit_raider",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.BanditLeader",
		Troop = "BanditLeader",
		Figure = "figure_bandit_04", // Vanilla bandit leader figure
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.BanditRaiderWolf",
		Troop = "BanditRaiderWolf",
	},

	//New in Reforged
	{
		ID = "Unit.RF.RF_BanditScoundrel",
		Troop = "RF_BanditScoundrel",
		Figure = "figure_bandit_02" // Vanilla bandit thug figure
	},
	{
		ID = "Unit.RF.RF_BanditRobber",
		Troop = "RF_BanditRobber",
		Figure = "figure_rf_bandit_robber",
		StartingResourceMin = 90
	},
	{
		ID = "Unit.RF.RF_BanditHunter",
		Troop = "RF_BanditHunter",
		Figure = "figure_rf_bandit_hunter",
		StartingResourceMin = 100
	},
	{
		ID = "Unit.RF.RF_BanditVandal",
		Troop = "RF_BanditVandal",
		Figure = "figure_bandit_03" // Vanilla bandit raider figure
	},
	{
		ID = "Unit.RF.RF_BanditPillager",
		Troop = "RF_BanditPillager",
		Figure = "figure_rf_bandit_pillager",
		StartingResourceMin = 100
	},
	{
		ID = "Unit.RF.RF_BanditOutlaw",
		Troop = "RF_BanditOutlaw",
		Figure = "figure_rf_bandit_outlaw",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.RF_BanditBandit",
		Troop = "RF_BanditBandit",
		Figure = "figure_rf_bandit_bandit",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.RF_BanditHighwayman",
		Troop = "RF_BanditHighwayman",
		Figure = "figure_rf_bandit_highwayman",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditMarauder",
		Troop = "RF_BanditMarauder",
		Figure = "figure_bandit_03",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditSharpshooter",
		Troop = "RF_BanditSharpshooter",
		Figure = "figure_rf_bandit_sharpshooter",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditKiller",
		Troop = "RF_BanditKiller",
		Figure = "figure_rf_bandit_killer",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditBaron",
		Troop = "RF_BanditBaron",
		Figure = "figure_rf_bandit_baron",
		StartingResourceMin = 350
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
