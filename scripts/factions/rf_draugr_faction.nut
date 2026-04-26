this.rf_draugr_faction <- ::inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = ::Const.FactionType.RF_Draugr;
		this.m.Base = "world_base_03";
		this.m.TacticalBase = "bust_base_rf_draugr_01";
		this.m.CombatMusic = ::Const.Music.RF_DraugrTracks;
		this.m.Footprints = ::Const.UndeadFootprints;
		this.m.PlayerRelation = 0.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	function getType()
	{
		// Return Undead as the faction type during rumor generation so that
		// the rumor text is appropriate for this faction. Otherwise we'd have
		// to completely overwrite `tavern_building.getRumor` to accommodate it.
		return ::Reforged.__IsDuringGetRumor ? ::Const.FactionType.Undead : this.m.Type;
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}
});

