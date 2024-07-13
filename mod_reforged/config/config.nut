::Reforged.Config <- {
	XPOverride = false, // Is set to true during actor.onActorKilled to prevent any xp gain via player.getXP function. Then set to false afterwards. This is to do our own override of XP gain system based on damage dealt ratios.
	VeteranPerksLevelStep = 4, // During veteran character levels, a new perk point is gained every this many levels.

	UI = {
		WorldBannerYOffset = 50
	}
}
