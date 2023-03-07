this.pg_rf_fast <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_fast";
		this.m.Name = "Fast";
		this.m.Icon = "ui/perk_groups/rf_fast.png";
		this.m.FlavorText = [
			"is fast",
			"runs fast",
			"is fast like a flash",
			"has fast feet",
			"maneuvers fast",
			"has fast steps",
			"is a fast sprinter"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_survival_instinct"],
				["perk.quick_hands"],
				["perk.relentless"],
				[],
				[],
				["perk.overwhelm"],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
});
