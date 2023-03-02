::Reforged.Config <- {
	IsLegendaryDifficulty = true,
	HiringCostVariance = 0.2,	// Hiring cost for recruits after gear is randomized +- this value. 0.0 = no variance. 0.2 = it varies between 80% and 120% of its original cost
	HiringCostLuck = 200,	// Luck for rerolling hiring cost. Every 100 luck = 1 reroll. With multiple rerolls present only the closest to the original hiring cost is taken. 0 luck = to linear distribution between min and max
}
