this.pg_special_rf_student <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_student";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_student.png";
		this.m.Chance = 10;
		this.m.Tree = [
			["perk.student"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}
});
