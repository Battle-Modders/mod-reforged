this.pg_rf_tough <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_tough";
		this.m.Name = "Tough";
		this.m.Icon = "ui/perk_groups/rf_tough.png";
		this.m.Tree = [
			["perk.colossus"],
			["perk.hold_out"],
			["perk.taunt"],
			[],
			["perk.rf_vanquisher"],
			["perk.rf_second_wind"],
			["perk.killing_frenzy"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 1.0 : ::Math.max(1, talents[::Const.Attributes.Hitpoints]) * 1.2;
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_power":
				return 1.2;
		}
	}
});
