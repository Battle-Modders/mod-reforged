::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	// Playlist of songs that are played at the start of battle, while you haven't discovered any enemy yet
	q.m.RF_NeutralCombatTracks <- ["music/rf_silent_music.ogg"];
	q.m.__RF_IsPlayingRealCombatMusic <- false;

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

	q.onShow = @(__original) { function onShow()
	{
		__original();

		// feat: Combat Music no longer plays at the start in order to not spoil the enemy type you are up against.
		// Note: onShow() is called AFTER the onDiscovered of entities that are discovered
		// from the start of the combat. So, if an entity was already discovered and
		// started playing the real music, then we don't want to overwrite that.
		if (!this.m.__RF_IsPlayingRealCombatMusic)
		{
			foreach (p in ::Tactical.State.getStrategicProperties().Parties)
			{
				// Only hide the music when fighting locations which hide their defenders
				if (!p.isLocation() || p.isShowingDefenders() || p.isAlliedWithPlayer())
					continue;

				// We overwrite the vanilla setTrackList call by calling it again with our neutral track list.
				::Music.setTrackList(this.m.RF_NeutralCombatTracks, ::Const.Sound.CrossFadeTime);
				break;
			}
		}
	}}.onShow;

	q.onBattleEnded = @(__original) { function onBattleEnded()
	{
		// Set the real music flag back to false at the end of battle.
		this.m.__RF_IsPlayingRealCombatMusic = false;
		__original();
	}}.onBattleEnded;

	q.showRetreatScreen = @(__original) function ( _tag = null )
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
		return __original(_tag);
	}

// New Functions
	// Enable combat music, similar to how Vanilla does it in the onShow function
	q.RF_playActualTrackList <- function()
	{
		if (this.m.__RF_IsPlayingRealCombatMusic)
			return;

		this.m.__RF_IsPlayingRealCombatMusic = true;

		if (this.m.Scenario != null)
		{
			::Music.setTrackList(this.m.Scenario.getMusic(), ::Const.Music.RF_CrossFadeTimeToRealMusic);
		}
		else
		{
			if (this.m.StrategicProperties != null)
			{
				::Music.setTrackList(this.m.StrategicProperties.Music, ::Const.Music.RF_CrossFadeTimeToRealMusic);
			}
			else
			{
				::Music.setTrackList(::Const.Music.BattleTracks[this.m.Factions.getHostileFactionWithMostInstances()], ::Const.Music.RF_CrossFadeTimeToRealMusic);
			}
		}
	}
});
