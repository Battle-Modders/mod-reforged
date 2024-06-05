this.pg_rf_vigorous <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_vigorous";
		this.m.Name = "Vigorous";
		this.m.Icon = "ui/perk_groups/rf_vigorous.png";
		this.m.FlavorText = [
			"is unnaturally resilient",
			"is stubbornly resilient",
			"is staunchly resilient",
			"has a resilient will",
			"resiliently persists",
			"seems unwaveringly resilient",
			"is resilient beyond measure"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_survival_instinct"],
				["perk.hold_out"],
				["perk.fortified_mind"],
				["perk.rf_decisive"],
				[],
				["perk.rf_fresh_and_furious"],
				["perk.indomitable"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_shield": 1.2
		};
	}
});
