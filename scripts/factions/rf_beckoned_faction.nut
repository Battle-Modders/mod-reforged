this.rf_beckoned_faction <- ::inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = ::Const.FactionType.RF_Beckoned;
		this.m.Base = "world_base_10";
		this.m.TacticalBase = "bust_base_beasts";
		this.m.CombatMusic = ::Const.Music.BeastsTracks;
		this.m.Footprints = ::Const.BeastFootprints;
		this.m.PlayerRelation = 100.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
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

