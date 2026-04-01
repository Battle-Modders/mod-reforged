local units = [
	{
		ID = "Unit.RF.BanditThug",
		Troop = "BanditThug",
		Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.Wardog",
		Troop = "Wardog"
	},
	{
		ID = "Unit.RF.BanditMarksmanLOW",	// Brigand Poacher
		Troop = "BanditMarksmanLOW",
		Figure = "figure_bandit_01", // Vanilla bandit poacher figure
	},
	{
		ID = "Unit.RF.BanditMarksman",
		Troop = "BanditMarksman",
		Figure = "figure_rf_bandit_marksman",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.BanditRaider",
		Troop = "BanditRaider",
		Figure = "figure_bandit_03", // vanilla bandit raider figure
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.BanditLeader",
		Troop = "BanditLeader",
		Figure = "figure_bandit_04" // Vanilla bandit leader figure
	},
	{
		ID = "Unit.RF.BanditRaiderWolf",
		Troop = "BanditRaiderWolf"
	},

	//New in Reforged
	{
		ID = "Unit.RF.RF_BanditThugTough",
		Troop = "RF_BanditThugTough",
		Figure = "figure_bandit_02", // Vanilla bandit thug figure
		StartingResourceMin = 100
	},
	{
		ID = "Unit.RF.RF_BanditPillager",
		Troop = "RF_BanditPillager",
		Figure = "figure_rf_bandit_pillager",
		StartingResourceMin = 100
	},
	{
		ID = "Unit.RF.RF_BanditPillagerTough",
		Troop = "RF_BanditPillagerTough",
		Figure = "figure_rf_bandit_pillager",
		StartingResourceMin = 140
	},
	{
		ID = "Unit.RF.RF_BanditVandal",
		Troop = "RF_BanditVandal",
		Figure = "figure_rf_bandit_vandal",
		StartingResourceMin = 100
	},
	{
		ID = "Unit.RF.RF_BanditRaiderTough",
		Troop = "RF_BanditRaiderTough",
		Figure = "figure_bandit_03", // vanilla bandit raider figure
		StartingResourceMin = 185
	},
	{
		ID = "Unit.RF.RF_BanditOutlaw",
		Troop = "RF_BanditOutlaw",
		Figure = "figure_rf_bandit_outlaw",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.RF_BanditSharpshooter",
		Troop = "RF_BanditSharpshooter",
		Figure = "figure_rf_bandit_sharpshooter",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditMarauder",
		Troop = "RF_BanditMarauder",
		Figure = "figure_rf_bandit_marauder",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditMarauderTough",
		Troop = "RF_BanditMarauderTough",
		Figure = "figure_rf_bandit_marauder",
		StartingResourceMin = 250
	},
	{
		ID = "Unit.RF.RF_BanditHighwayman",
		Troop = "RF_BanditHighwayman",
		Figure = "figure_rf_bandit_highwayman",
		StartingResourceMin = 225
	},
	{
		ID = "Unit.RF.RF_BanditBaron",
		Troop = "RF_BanditBaron",
		Figure = "figure_rf_bandit_baron",
		StartingResourceMin = 350
	}
];

foreach (unitDef in units)
{
	::Reforged.Spawns.Units[unitDef.ID] <- unitDef;
}
