::Reforged.Config <- {
	HiringCostVariance = 0.2,	// Hiring cost for recruits after gear is randomized +- this value. 0.0 = no variance. 0.2 = it varies between 80% and 120% of its original cost
	HiringCostLuck = 200,	// Luck for rerolling hiring cost. Every 100 luck = 1 reroll. With multiple rerolls present only the closest to the original hiring cost is taken. 0 luck = to linear distribution between min and max,
	XPOverride = false, // Is set to true during actor.onActorKilled to prevent any xp gain via player.getXP function. Then set to false afterwards. This is to do our own override of XP gain system based on damage dealt ratios.
	VeteranPerksLevelStep = 4, // During veteran character levels, a new perk point is gained every this many levels.

	UI = {
		WorldBannerYOffset = 50
	}
}
