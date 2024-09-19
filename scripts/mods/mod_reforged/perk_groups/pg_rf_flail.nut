this.pg_rf_flail <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_flail";
		this.m.Name = "Flail";
		this.m.Icon = "ui/perk_groups/rf_flail.png";
		this.m.Tree = [
			[],
			[],
			["perk.rf_whirling_death"],
			["perk.mastery.flail"],
			[],
			[],
			["perk.rf_flail_spinner"]
		];
	}
});
