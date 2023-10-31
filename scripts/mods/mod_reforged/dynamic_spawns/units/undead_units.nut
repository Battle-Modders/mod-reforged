local units = [
// Skeletons
	{
		ID = "Unit.SkeletonLight",
		Troop = "SkeletonLight",
		Figure = "figure_skeleton_01",      // Exclusive
		Cost = 13
	},
	{
		ID = "Unit.SkeletonMedium",
		Troop = "SkeletonMedium",
		Figure = "figure_skeleton_02",
		Cost = 20
	},
	{
		ID = "Unit.SkeletonMediumPolearm",
		Troop = "SkeletonMediumPolearm",
		Figure = "figure_skeleton_02",
		Cost = 25
	},
	{
		ID = "Unit.SkeletonHeavy",
		Troop = "SkeletonHeavy",
		Figure = "figure_skeleton_03",
		Cost = 35
	},
	{
		ID = "Unit.SkeletonHeavyPolearm",
		Troop = "SkeletonHeavyPolearm",
		Figure = "figure_skeleton_03",
		Cost = 35
	},
	{
		ID = "Unit.SkeletonPriest",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40
	},
	{
		ID = "Unit.SkeletonPriestH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40 + 30,
		SubPartyDef = {ID = "SubPartyHonor"}
	},
	{
		ID = "Unit.SkeletonPriestHH",
		Troop = "SkeletonPriest",
		Figure = "figure_skeleton_04",
		Cost = 40 + 30 + 30,
		SubPartyDef = {ID = "SubPartyHonorHonor"}
	},

// Bodyguards for Priests
	{
		ID = "Unit.SkeletonHeavyBodyguard",
		Troop = "SkeletonHeavyBodyguard",
		Figure = "figure_zombie_03",
		Cost = 30
	},

// Vampire
	{
		ID = "Unit.VampireLOW",
		Troop = "VampireLOW",
		Figure = "figure_vampire_01",       // Exclusive
		Cost = 30
	},
	{
		ID = "Unit.Vampire",
		Troop = "Vampire",
		Figure = "figure_vampire_02",       // Exclusive
		Cost = 40
	}
]

foreach (unitDef in units)
{
	if (!("Cost" in unitDef))
		unitDef.Cost <- ::Const.World.Spawn.Troops[unitDef.Troop].Cost;
	::DynamicSpawns.Public.registerUnit(unitDef);
}
