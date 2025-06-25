::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
	// Public
	q.m.RF_NeutralCombatTracks <- ["music/rf_silent_music.ogg"];	// Playlist of songs that are played at the start of battle, while you haven't discovered any enemy yet

	// Private
	q.m.RF_IsPlayingRealCombatMusic <- false;

	q.initMap = @(__original) { function initMap()
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
	}}.initMap;

	q.onShow = @(__original) { function onShow()
	{
		__original();

		// Feat: Combat Music no longer plays right from the start in order to not spoil the enemy type you are up against
		// We overwrite the vanilla setTrackList call by calling it again with our neutral track list
		::Music.setTrackList(this.m.RF_NeutralCombatTracks, ::Const.Sound.CrossFadeTime);
		this.m.RF_IsPlayingRealCombatMusic = false;
	}}.onShow;

	q.showRetreatScreen = @(__original) function ( _tag = null )
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
		return __original(_tag);
	}

// New Functions
	// Enable combat music, similar to how Vanilla does it in the onShow function
	q.RF_playActualTrackList <- function()
	{
		if (this.m.RF_IsPlayingRealCombatMusic) return;
		this.m.RF_IsPlayingRealCombatMusic = true;

		if (this.m.Scenario != null)
		{
			::Music.setTrackList(this.m.Scenario.getMusic(), ::Const.Sound.CrossFadeTime);
		}
		else
		{
			if (this.m.StrategicProperties != null)
			{
				::Music.setTrackList(this.m.StrategicProperties.Music, ::Const.Music.CrossFadeTime);
			}
			else
			{
				::Music.setTrackList(::Const.Music.BattleTracks[this.m.Factions.getHostileFactionWithMostInstances()], ::Const.Music.CrossFadeTime);
			}
		}
	}
});
