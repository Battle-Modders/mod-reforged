this.pg_special_rf_back_to_basics <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_back_to_basics";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_back_to_basics.png";
		this.m.Chance = 4;
		this.m.Tree = [
			[],
			[],
			[],
			[],
			["perk.rf_back_to_basics"],
			[],
			[]
		];
	}
});
