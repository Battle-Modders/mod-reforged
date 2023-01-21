this.pg_special_rf_personal_armor <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.personal_armor";
		this.m.Name = "Special Perks";
		this.m.FlavorText = [
			"Knows how to keep good care of his personal armor."
		];
		this.m.Chance = 0;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				["perk.rf_personal_armor"],
				[]
			]
		};
	}
});
