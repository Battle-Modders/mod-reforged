this.pg_rf_dagger <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_dagger";
		this.m.Name = "Dagger";
		this.m.FlavorText = [
			"daggers"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_featherweight"],
				["perk.backstabber"],
				["perk.rf_between_the_ribs"],
				["perk.mastery.dagger"],
				["perk.rf_double_strike"],
				["perk.overwhelm"],
				["perk.rf_swift_stabs"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.5
		};
	}
});
