local units = [
	//Vanilla Entities
	{
		ID = "Unit.RF.Footman",
		Troop = "Footman",
		Figure = "figure_noble_01"
	},
	{
		ID = "Unit.RF.Billman",
		Troop = "Billman",
		Figure = "figure_noble_01"
	},
	{
		ID = "Unit.RF.Arbalester",
		Troop = "Arbalester"
		Figure = "figure_noble_01"
	},
	{
		ID = "Unit.RF.ArmoredWardog",
		Troop = "ArmoredWardog",
		StartingResourceMin = 126
	},
	{
		ID = "Unit.RF.StandardBearer",
		Troop = "StandardBearer",
		Figure = "figure_noble_02",
		StartingResourceMin = 185	// In Vanilla they appear in a group of 240 cost
	},
	{
		ID = "Unit.RF.Sergeant",
		Troop = "Sergeant",
		Figure = "figure_noble_02",
		StartingResourceMin = 185	// In Vanilla they appear in a group of 235 cost in noble caravans
	},
	{
		ID = "Unit.RF.Greatsword",
		Troop = "Greatsword",
		Figure = "figure_noble_02",
		StartingResourceMin = 350	// In Vanilla they appear in a group of 235 cost in noble caravans
	},
	{
		ID = "Unit.RF.Knight",
		Troop = "Knight",
		Figure = "figure_noble_03",
		StartingResourceMin = 350,	// In Vanilla they appear in a group of 235 cost in noble caravans
		StaticDefs = {
			Units = [
				{ BaseID =  "Unit.RF.RF_Squire" }
			]
		}
	},
	{	// This already exists under human_units but noble caravans use a different figure
		ID = "Unit.RF.NobleCaravanDonkey",
		Troop = "CaravanDonkey",
		Figure = "cart_01"
	},

	//New in Reforged
	{
		ID = "Unit.RF.RF_FootmanHeavy",
		Troop = "RF_FootmanHeavy",
		Figure = "figure_noble_02",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.RF_BillmanHeavy",
		Troop = "RF_BillmanHeavy",
		Figure = "figure_noble_02",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.RF_ArbalesterHeavy",
		Troop = "RF_ArbalesterHeavy",
		Figure = "figure_noble_01",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.RF_ManAtArms",
		Troop = "RF_ManAtArms",
		Figure = "figure_noble_02",
		StartingResourceMin = 300
	},
	{
		ID = "Unit.RF.RF_Fencer",
		Troop = "RF_Fencer",
		Figure = "figure_noble_01",
		StartingResourceMin = 350
	},
	{
		ID = "Unit.RF.RF_Herald",
		Troop = "RF_Herald",
		Figure = "figure_noble_02",
		StartingResourceMin = 350,
		StaticDefs = {
			Units = [
				{ BaseID =  "Unit.RF.RF_HeraldsBodyguard" },
				{ BaseID =  "Unit.RF.RF_HeraldsBodyguard" }
			]
		}
	},
	{
		ID = "Unit.RF.RF_Marshal",
		Troop = "RF_Marshal",
		Figure = "figure_noble_02",
		StartingResourceMin = 350
	},
	{
		ID = "Unit.RF.RF_KnightAnointed",
		Troop = "RF_KnightAnointed",
		Figure = "figure_noble_03",
		StartingResourceMin = 450,
		StaticDefs = {
			Units = [
				{ BaseID =  "Unit.RF.RF_Squire" },
				{ BaseID =  "Unit.RF.RF_Squire" }
			]
		}
	},
	{
		ID = "Unit.RF.RF_HeraldsBodyguard",
		Troop = "RF_HeraldsBodyguard",
		Figure = "figure_noble_02"
	},
	{
		ID = "Unit.RF.RF_Squire",
		Troop = "RF_Squire",
		Figure = "figure_noble_01"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
