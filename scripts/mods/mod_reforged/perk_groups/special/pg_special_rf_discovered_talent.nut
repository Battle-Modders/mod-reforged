this.pg_special_rf_discovered_talent <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_discovered_talent";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_discovered_talent.png";
		this.m.Chance = 4;
		this.m.Tree = [
			["perk.rf_discovered_talent"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}
});
