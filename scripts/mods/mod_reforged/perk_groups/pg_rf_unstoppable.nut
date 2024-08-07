this.pg_rf_unstoppable <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_unstoppable";
		this.m.Name = "Unstoppable";
		this.m.Icon = "ui/perk_groups/rf_unstoppable.png";
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
				["perk.coup_de_grace"],
				[],
				["perk.rf_the_rush_of_battle"],
				["perk.lone_wolf"],
				["perk.rf_unstoppable"],
				[]
			]
		};
	}
});
