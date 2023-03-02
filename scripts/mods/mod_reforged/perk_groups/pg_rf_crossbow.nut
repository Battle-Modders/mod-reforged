this.pg_rf_crossbow <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_crossbow";
		this.m.Name = "Crossbow";
		this.m.Icon = "ui/perk_groups/rf_crossbow.png";
		this.m.FlavorText = [
			"crossbows"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_power_shot"],
				[],
				[],
				["perk.mastery.crossbow"],
				["perk.rf_iron_sights"],
				["perk.rf_muscle_memory"],
				["perk.rf_take_aim"]
			]
		};
	}
});
