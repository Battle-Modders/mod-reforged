this.pg_rf_noble <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_noble";
		this.m.Name = "Noble";
		this.m.FlavorText = [
			"is of noble birth",
			"hails from a noble family",
			"has noble blood in his veins"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rf_family_pride"],
				[],
				[],
				[],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 1.5
		};
	}
});
