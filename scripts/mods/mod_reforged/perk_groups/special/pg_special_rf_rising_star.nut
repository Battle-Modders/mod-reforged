this.pg_special_rf_rising_star <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_rising_star";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_rising_star.png";
		this.m.FlavorText = [
			"Has the talent to rise and shine above all others!"
		];
		this.m.Chance = 2;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_rising_star"]
			]
		};
	}
});
