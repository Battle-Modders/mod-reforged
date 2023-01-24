this.pgc_rf_shared_1 <- ::inherit(::DPF.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_shared_1";
		this.m.Name = "Trait";
		this.m.OrderOfAssignment = 2;
		this.m.Min = 5;
		this.m.TooltipPrefix = "He";
		this.m.Groups = [
			"pg.rf_agile",
			"pg.rf_devious",
			"pg.rf_fast",
			"pg.rf_large",
			"pg.rf_leadership",
			"pg.rf_resilient",
			"pg.rf_sturdy",
			"pg.rf_tactician",
			"pg.rf_talented",
			"pg.rf_trained",
			"pg.rf_unstoppable",
			"pg.rf_vicious",
		];
	}
});
