this.pg_special_rf_professional <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_professional";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_professional.png";
		this.m.FlavorText = [
			"Carries himself with the grace of a professional soldier."
		];
		this.m.Chance = 0;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_professional"]
			]
		};
	}
});
