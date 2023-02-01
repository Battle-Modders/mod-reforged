this.pg_rf_tactician <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_tactician";
		this.m.Name = "Tactician";
		this.m.Icon = "ui/perk_groups/rf_tactician.png";
		this.m.FlavorText = [
			"is skilled in battlefield tactics",
			"claims to have studied battlefield tactics",
			"has a tactical and calculating mind"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.rf_shield_sergeant"],
				["perk.rf_onslaught"],
				["perk.rf_hold_steady"],
				[],
				["perk.rf_blitzkrieg"]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
});
