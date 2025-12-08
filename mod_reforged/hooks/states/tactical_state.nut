::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	q.initMap = @(__original) { function initMap()
	{
		// The same battle will always produce the exact same layout
		// This has no influence over troop spawning as those will be seeded by "combatSeed" later on
		// Our seeding always happens first. If vanilla then chooses to use their own fixed seed, they will replace our attempt
		foreach (party in this.m.StrategicProperties.Parties)
		{
			::Reforged.Math.seedRandom(
				"RF_FixedCombatMapSeed",	// Fixed salt, specific to use-case
				party.getCombatSeed(),		// world entity specific salt. Vanilla serializes the CombatSeed for each world entity.
				party.getName(),			// world entity specific salt
				party.getFaction(),			// Faction specific salt
				party.getTile().X * 200,	// Position specific salt
				party.getTile().Y			// Position specific salt
			);

			// Only need to do this for the first party in the list
			break;
		}

		__original();
	}}.initMap;

	q.showRetreatScreen = @(__original) function ( _tag = null )
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
		return __original(_tag);
	}
});
