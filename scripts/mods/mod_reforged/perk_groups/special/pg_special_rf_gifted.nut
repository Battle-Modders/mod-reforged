this.pg_special_rf_gifted <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_gifted";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perks/perk_56.png"; // gifted icon
		this.m.FlavorText = [
			"Seems naturally gifted for mercenary work!"
		];
		this.m.Chance = 5;
		this.m.Trees = {
			"default": [
				["perk.gifted"],
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
