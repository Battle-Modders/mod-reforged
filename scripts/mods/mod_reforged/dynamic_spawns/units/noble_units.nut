local units = [
	{
		ID = "Unit.NobleFootman",
		Troop = "Footman",
	},
	{
		ID = "Unit.NobleBillman",
		Troop = "Billman",
	},
	{
		ID = "Unit.NobleArbalester",
		Troop = "Arbalester"
	},
	{
		ID = "Unit.NobleArmoredWardog",
		Troop = "ArmoredWardog"
	},
	{
		ID = "Unit.NobleStandardBearer",
		Troop = "StandardBearer",
		Figure = "figure_noble_02"
	},
	{
		ID = "Unit.NobleSergeant",
		Troop = "Sergeant",
		Figure = "figure_noble_02"
	},
	{
		ID = "Unit.NobleZweihander",
		Troop = "Greatsword"
	},
	{
		ID = "Unit.NobleKnight",
		Troop = "Knight",
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
