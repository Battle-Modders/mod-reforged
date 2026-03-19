local unitBlocks = [
	{
		ID = "UnitBlock.RF.ScourgeSupport",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.SkeletonPriestPH" }],
				[1, { BaseID = "Unit.RF.SkeletonPriestHH" }],
				[1, { BaseID = "Unit.RF.NecromancerWithBodyguards" }]
			])
		}
	},
	{
		ID = "UnitBlock.RF.ScourgeSupportOrc",
		DynamicDefs = {
			Units = ::MSU.Class.WeightedContainer([
				[1, { BaseID = "Unit.RF.SkeletonPriestPH" }],
				[1, { BaseID = "Unit.RF.SkeletonPriestHH" }],
				[1, { BaseID = "Unit.RF.NecromancerWithBodyguardsOrc" }]
			])
		}
	},
	{
		ID = "UnitBlock.RF.GhoulMedium",
		DynamicDefs = {
			Units = [
				{ BaseID = "Unit.RF.GhoulLOW" },
				{ BaseID = "Unit.RF.Ghoul", RatioMax = 0.33 },
			]
		}
	},
];

foreach (blockDef in unitBlocks)
{
	::Reforged.Spawns.UnitBlocks[blockDef.ID] <- blockDef;
}
