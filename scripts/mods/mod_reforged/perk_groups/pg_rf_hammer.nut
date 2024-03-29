this.pg_rf_hammer <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_hammer";
		this.m.Name = "Hammer";
		this.m.Icon = "ui/perk_groups/rf_hammer.png";
		this.m.FlavorText = [
			"hammers"
		];
		this.m.Trees = {
			"default": [
				["perk.crippling_strikes"],
				[],
				["perk.rf_dent_armor"],
				["perk.mastery.hammer"],
				[],
				["perk.rf_deep_impact"],
				[]
			]
		};
	}
});
