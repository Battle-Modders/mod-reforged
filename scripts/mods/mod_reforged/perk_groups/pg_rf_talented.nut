this.pg_rf_talented <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_talented";
		this.m.Name = "Talented";
		this.m.FlavorText = [
			"is talented",
			"lives with talented ease",
			"has unparalleled talent",
			"is bright and talented",
			"is talented in many ways",
			"is talented beyond belief",
			"succeeds easily and with talent"
		];
		this.m.Trees = {
			"default": [
				["perk.student"],
				[],
				[],
				["perk.rf_discovered_talent"],
				["perk.rf_back_to_basics"],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.1
		};
	}
});
