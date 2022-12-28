this.pg_rf_leadership <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_leadership";
		this.m.Name = "Leadership";
		this.m.FlavorText = [
			"is a natural born leader",
			"has an aura of leadership",
			"seems like a capable leader"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rally_the_troops"],
				["perk.fortified_mind"],
				[],
				[],
				[],
				["perk.inspiring_presence"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.1,
			"pg.rf_polearm": -1
		};
	}
});
