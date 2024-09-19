this.pg_special_rf_professional <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_professional";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_professional.png";
		this.m.Chance = 0;
		this.m.Tree = [
			["perk.rf_professional"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}
});
