this.pgc_rf_shared_1 <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_shared_1";
		this.m.Name = "Shared";
		this.m.OrderOfAssignment = 2;
		this.m.Min = 2;
		this.m.Groups = [
			"pg.rf_agile",
			"pg.rf_fast",
			"pg.rf_tough",
			"pg.rf_vigorous",
			"pg.rf_tactician",
			"pg.rf_trained",
			"pg.rf_unstoppable",
			"pg.rf_vicious"
		];
	}
});
