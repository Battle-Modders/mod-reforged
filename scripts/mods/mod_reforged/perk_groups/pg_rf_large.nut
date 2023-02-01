this.pg_rf_large <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_large";
		this.m.Name = "Large";
		this.m.Icon = "ui/perk_groups/rf_large.png";
		this.m.FlavorText = [
			"is large",
			"is large and hulking",
			"has impressively large shoulders",
			"is a large sort",
			"looms large above you",
			"is mountainously large",
			"has large musculature"
		];
		this.m.Trees = {
			"default": [
				["perk.colossus"],
				["perk.steel_brow"],
				[],
				[],
				[],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_power": 1.2
		};
	}
});
