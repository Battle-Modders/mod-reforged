this.pg_rf_trained <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_trained";
		this.m.Name = "Trained";
		this.m.Icon = "ui/perks/rf_finesse.png";
		this.m.FlavorText = [
			"is well trained",
			"has great training",
			"is drilled and trained",
			"has combat training",
			"has trained a great deal",
			"has been trained by someone skillful",
			"is trained and disciplined",
			"has genuine training"
		];
		this.m.Trees = {
			"default": [
				["perk.fast_adaption"],
				[],
				["perk.rotation"],
				["perk.rf_vigilant"],
				["perk.underdog"],
				["perk.rf_finesse"],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.75
		};
	}
});
