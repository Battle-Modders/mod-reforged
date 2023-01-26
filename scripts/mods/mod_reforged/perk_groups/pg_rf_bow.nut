this.pg_rf_bow <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_bow";
		this.m.Name = "Bow";
		this.m.Icon = "ui/perks/perk_49.png"; // bow mastery icon
		this.m.FlavorText = [
			"bows"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_target_practice"],
				[],
				[],
				["perk.mastery.bow"],
				["perk.rf_flaming_arrows"],
				["perk.rf_eyes_up"],
				["perk.rf_hip_shooter"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.33,
			"pg.rf_ranged": 1.5
		};
	}
});
