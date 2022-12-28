this.pg_rf_pauper <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_pauper";
		this.m.Name = "Pauper";
		this.m.FlavorText = [
			"is a dreg of society",
			"looks utterly beaten down",
			"is a pitiful pile of flesh and bones"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_promised_potential"],
				[],
				[],
				[],
				["perk.rf_trauma_survivor"],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_talented": 0
		};
	}
});
