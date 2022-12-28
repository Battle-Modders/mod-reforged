this.pg_rf_unstoppable <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_unstoppable";
		this.m.Name = "Unstoppable";
		this.m.FlavorText = [
			"seems unstoppable",
			"lifts weights unstoppably",
			"seems unstoppably resolute",
			"acts unstoppable",
			"has unstoppable stamina",
			"is unstoppably strong"
		];
		this.m.Trees = {
			"default": [
				["perk.adrenaline"],
				[],
				[],
				["perk.rf_the_rush_of_battle"],
				["perk.lone_wolf"],
				["perk.rf_unstoppable"],
				["perk.killing_frenzy"]
			]
		};
	}
});
