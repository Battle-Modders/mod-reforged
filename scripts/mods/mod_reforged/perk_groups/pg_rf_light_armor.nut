this.pg_rf_light_armor <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_light_armor";
		this.m.Name = "Light Armor";
		this.m.Icon = "ui/perk_groups/rf_light_armor.png";
		this.m.Tree = [
			[],
			["perk.relentless"],
			["perk.dodge"],
			[],
			[],
			["perk.nimble"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.66;
	}
});
