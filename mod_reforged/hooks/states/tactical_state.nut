::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	q.initMap = @(__original) function()
	{
		// Feat: the same location will always produce the exact same layout
		// This has no influence over troop spawning as those will be seeded by "combatSeed" later on
		// Our seeding always happens first. If vanilla then chooses to use their own fixed seed, they will replace our attempt
		foreach (party in this.m.StrategicProperties.Parties)
		{
			if (party.isLocation())
			{
				::Reforged.Math.seedRandom(
					"RF_FixedLocationSeed",		// Fixed salt, specific to use-case
					party.getTypeID(),			// Location specific salt
					party.getName(),			// Location specific salt
					party.getFaction(),			// Faction specific salt
					party.getTile().X * 200,	// Position specific salt
					party.getTile().Y			// Position specific salt
				);
				break;
			}
		}

		__original();
	}

	q.showRetreatScreen = @(__original) function ( _tag = null )
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
		return __original(_tag);
	}
});
