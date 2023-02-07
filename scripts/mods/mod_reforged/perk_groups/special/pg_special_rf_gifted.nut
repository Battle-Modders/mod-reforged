this.pg_special_rf_gifted <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_gifted";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_gifted.png";
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
