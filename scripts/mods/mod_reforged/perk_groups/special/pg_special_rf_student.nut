this.pg_special_rf_student <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_student";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_student.png";
		this.m.FlavorText = [
			"Is quick to pick up new things."
		];
		this.m.Chance = 10;
		this.m.Trees = {
			"default": [
				["perk.student"],
				[],
				[],
				[],
				[],
				[],
				[]
			]
		};
	}
});
