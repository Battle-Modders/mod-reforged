this.pg_rf_crossbow <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_crossbow";
		this.m.Name = "Crossbow";
		this.m.Icon = "ui/perk_groups/rf_crossbow.png";
		this.m.Tree = [
			["perk.rf_power_shot"],
			[],
			[],
			["perk.mastery.crossbow"],
			["perk.rf_iron_sights"],
			[],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.5;
	}
});
