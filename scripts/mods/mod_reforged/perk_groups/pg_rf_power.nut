this.pg_rf_power <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_power";
		this.m.Name = "Powerful Strikes";
		this.m.Icon = "ui/perk_groups/rf_power.png";
		this.m.FlavorText = [
			"powerful weapons"
		];
		this.m.Trees = {
			"default": [
				["perk.recover"],
				["perk.rf_vigorous_assault"],
				["perk.rotation"],
				["perk.rf_death_dealer"],
				["perk.rf_formidable_approach"],
				["perk.rf_sweeping_strikes"],
				[]
			]
		};
	}
});
