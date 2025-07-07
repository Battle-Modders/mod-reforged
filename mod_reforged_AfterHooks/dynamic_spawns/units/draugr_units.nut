local units = [
	{
		ID = "Unit.RF.RF_DraugrThrall",
		Troop = "RF_DraugrThrall",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrWarrior",
		Troop = "RF_DraugrWarrior",
		// Figure = "figure_bandit_02",
		StartingResourceMin = 150
	},
	{
		ID = "Unit.RF.RF_DraugrHuskarl",
		Troop = "RF_DraugrHuskarl",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrHero",
		Troop = "RF_DraugrHero",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrHeroChampion",
		Troop = "RF_DraugrHeroChampion",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrShaman",
		Troop = "RF_DraugrShaman",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrShamanWithBodyguards",
		Troop = "RF_DraugrShaman",
		// Figure = ["figure_necromancer_01", "figure_necromancer_02"],
		Cost = 60,
		StaticDefs = {
			Parties = [
				{ BaseID = "RF_DraugrShamanBodyguards" }
			]
		}
	},
	// Bodyguards
	{
		ID = "Unit.RF.RF_DraugrThrallBodyguard",
		Troop = "RF_DraugrThrallBodyguard",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrWarriorBodyguard",
		Troop = "RF_DraugrWarriorBodyguard",
		// Figure = "figure_bandit_02"
	},
	{
		ID = "Unit.RF.RF_DraugrHuskarlBodyguard",
		Troop = "RF_DraugrHuskarlBodyguard",
		// Figure = "figure_bandit_02"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
