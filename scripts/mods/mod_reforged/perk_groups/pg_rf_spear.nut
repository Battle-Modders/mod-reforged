this.pg_rf_spear <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_spear";
		this.m.Name = "Spear";
		this.m.Icon = "ui/perks/perk_45.png"; // spear mastery icon
		this.m.FlavorText = [
			"spears"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_spear_advantage"],
				[],
				[],
				["perk.mastery.spear"],
				["perk.rf_two_for_one"],
				["perk.rf_through_the_gaps"],
				["perk.rf_king_of_all_weapons"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 1.33
		};
	}
});
