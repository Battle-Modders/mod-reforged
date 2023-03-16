this.pg_rf_hammer_enemy <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_hammer_enemy";
		this.m.Name = "Hammer";
		this.m.Icon = "ui/perk_groups/rf_hammer.png";
		this.m.FlavorText = [
			"hammers"
		];
		this.m.Trees = {
			"default": [
				[],
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
