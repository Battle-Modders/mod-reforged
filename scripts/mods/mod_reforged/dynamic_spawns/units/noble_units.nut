local units = [
	{
		ID = "Unit.NobleFootman",
		Troop = "Footman",
		Cost = 20
	},
	{
		ID = "Unit.NobleBillman",
		Troop = "Billman",
		Cost = 15
	},
	{
		ID = "Unit.NobleArbalester",
		Troop = "Arbalester",
		Cost = 20
	},
	{
		ID = "Unit.NobleArmoredWardog",
		Troop = "ArmoredWardog",
		Cost = 8
	},
	{
		ID = "Unit.NobleStandardBearer",
		Troop = "StandardBearer",
		Cost = 20,
		Figure = "figure_noble_02"
	},
	{
		ID = "Unit.NobleSergeant",
		Troop = "Sergeant",
		Cost = 25,
		Figure = "figure_noble_02"
	},
	{
		ID = "Unit.NobleZweihander",
		Troop = "Greatsword",
		Cost = 25
	},
	{
		ID = "Unit.NobleKnight",
		Troop = "Knight",
		Cost = 35,
		Figure = "figure_noble_03"
	},

	{   // This already exists under human_units but noble caravans use a different figure
		ID = "Unit.NobleCaravanDonkey",
		Troop = "CaravanDonkey",
		Cost = 10,      // 0 in Vanilla
		Figure = "cart_01"
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
