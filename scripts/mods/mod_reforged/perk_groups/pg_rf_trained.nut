this.pg_rf_trained <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_trained";
		this.m.Name = "Trained";
		this.m.Icon = "ui/perk_groups/rf_trained.png";
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
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.75;
	}
});
