::Reforged.Config <- {
	XPOverride = false, // Is set to true during actor.onActorKilled to prevent any xp gain via player.getXP function. Then set to false afterwards. This is to do our own override of XP gain system based on damage dealt ratios.
	VeteranPerksLevelStep = 4, // During veteran character levels, a new perk point is gained every this many levels.

	UI = {
		WorldBannerYOffset = 50
	},

	// Chance that units of a certain tier can spawn with armor attachments.
	// Is used directly within entity files to roll for the chance
	ArmorAttachmentChance = {
		Tier4 = 40,
		Tier3 = 30,
		Tier2 = 20,
		Tier1 = 10
	}
}
