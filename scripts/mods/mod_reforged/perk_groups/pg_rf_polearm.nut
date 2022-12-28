this.pg_rf_polearm <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_polearm";
		this.m.Name = "Polearm";
		this.m.FlavorText = [
			"polearms"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rf_bolster"],
				["perk.rf_leverage"],
				["perk.mastery.polearm"],
				["perk.rf_intimidate"],
				["perk.rf_long_reach"],
				["perk.rf_follow_up"]
			]
		};
	}
});
