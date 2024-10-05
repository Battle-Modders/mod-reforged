this.pgc_rf_exclusive_1 <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_exclusive_1";
		this.m.Name = "Exclusive";
		this.m.OrderOfAssignment = 1;
		this.m.Min = 0;
		this.m.TooltipPrefix = "%name%";
		this.m.Groups = [
			"pg.rf_knave",
			"pg.rf_laborer",
			"pg.rf_militia",
			"pg.rf_noble",
			"pg.rf_pauper",
			"pg.rf_raider",
			"pg.rf_soldier",
			"pg.rf_swordmaster",
			"pg.rf_wildling",
			"pg.rf_trapper"
		];
	}
});
