this.pg_special_rf_rising_star <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_rising_star";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_rising_star.png";
		this.m.Chance = 2;
		this.m.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_rising_star"]
		];
	}
});
