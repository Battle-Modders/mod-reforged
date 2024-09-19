this.pg_rf_tactician <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_tactician";
		this.m.Name = "Tactician";
		this.m.Icon = "ui/perk_groups/rf_tactician.png";
		this.m.Tree = [
			[],
			[],
			["perk.rf_shield_sergeant"],
			["perk.rf_onslaught"],
			["perk.rf_hold_steady"],
			[],
			["perk.rf_blitzkrieg"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
});
