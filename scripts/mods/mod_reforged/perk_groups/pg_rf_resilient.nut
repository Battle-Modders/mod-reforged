this.pg_rf_resilient <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_resilient";
		this.m.Name = "Resilent";
		this.m.Icon = "ui/perk_groups/rf_resilient.png";
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
				["perk.nine_lives"],
				["perk.hold_out"],
				["perk.fortified_mind"],
				[],
				["perk.rf_survival_instinct"],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_shield": 1.2
		};
	}
});
