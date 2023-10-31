local units = [
	{
		ID = "Unit.RF_BanditScoundrel",
		Troop = "RF_BanditScoundrel",
		Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF_BanditRobber",
		Troop = "RF_BanditRobber",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditHunter",
		Troop = "RF_BanditHunter",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditVandal",
		Troop = "RF_BanditVandal",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditPillager",
		Troop = "RF_BanditPillager",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditOutlaw",
		Troop = "RF_BanditOutlaw",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditBandit",
		Troop = "RF_BanditBandit",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditHighwayman",
		Troop = "RF_BanditHighwayman",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditMarauder",
		Troop = "RF_BanditMarauder",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditSharpshooter",
		Troop = "RF_BanditSharpshooter",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditKiller",
		Troop = "RF_BanditKiller",
		Figure = "figure_bandit_03"
	},
	{
		ID = "Unit.RF_BanditBaron",
		Troop = "RF_BanditBaron",
		Figure = "figure_bandit_04",
		StartingResourceMin = 400
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
