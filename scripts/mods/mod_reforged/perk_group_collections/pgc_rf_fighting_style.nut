this.pgc_rf_fighting_style <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_fighting_style";
		this.m.Name = "Fighting Style";
		this.m.OrderOfAssignment = 5;
		this.m.Min = 2;
		this.m.Groups = [
			"pg.rf_power",
			"pg.rf_ranged",
			"pg.rf_shield",
			"pg.rf_swift"
		];
	}
});
