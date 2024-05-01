this.pg_rf_polearm <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_polearm";
		this.m.Name = "Polearm";
		this.m.Icon = "ui/perk_groups/rf_polearm.png";
		this.m.FlavorText = [
			"polearms"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.rf_leverage"],
				["perk.mastery.polearm"],
				[],
				[],
				["perk.rf_long_reach"]
			]
		};
	}
});
