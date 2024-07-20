this.pgc_rf_armor <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_armor";
		this.m.Name = "Armor";
		this.m.OrderOfAssignment = 4;
		this.m.Min = 2;
		this.m.TooltipPrefix = "Prefers wearing";
		this.m.Groups = [
			"pg.rf_light_armor",
			"pg.rf_medium_armor",
			"pg.rf_heavy_armor"
		];
	}
});
