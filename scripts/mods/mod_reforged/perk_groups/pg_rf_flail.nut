this.pg_rf_flail <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_flail";
		this.m.Name = "Flail";
		this.m.Icon = "ui/perk_groups/rf_flail.png";
		this.m.FlavorText = [
			"flails"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_from_all_sides"],
				[],
				["perk.rf_small_target"],
				["perk.mastery.flail"],
				["perk.rf_whirling_death"],
				["perk.head_hunter"],
				["perk.rf_flail_spinner"]
			]
		};
	}
});
