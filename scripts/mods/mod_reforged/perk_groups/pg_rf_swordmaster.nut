this.pg_rf_swordmaster <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_swordmaster";
		this.m.Name = "Swordmaster";
		this.m.Icon = "ui/perk_groups/rf_swordmaster.png";
		this.m.FlavorText = [
			"is a masterful swordsman",
			"is a renowned swordmaster",
			"is a master of the sword"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[
					"perk.rf_swordmaster_blade_dancer",
					"perk.rf_swordmaster_metzger",
					"perk.rf_swordmaster_juggernaut",
					"perk.rf_swordmaster_versatile_swordsman",
					"perk.rf_swordmaster_precise",
					"perk.rf_swordmaster_grappler",
					"perk.rf_swordmaster_reaper",
				],
				[],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_sword": -1,
			"pg.rf_ranged": 0
		};
	}
});
