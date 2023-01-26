this.pg_rf_crossbow <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_crossbow";
		this.m.Name = "Crossbow";
		this.m.Icon = "ui/perks/perk_48.png"; // crossbow mastery icon
		this.m.FlavorText = [
			"crossbows"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_power_shot"],
				["perk.rf_entrenched"],
				[],
				["perk.mastery.crossbow"],
				["perk.rf_iron_sights"],
				["perk.rf_muscle_memory"],
				["perk.rf_take_aim"]
			]
		};
	}
});
