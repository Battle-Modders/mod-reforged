this.pgc_rf_ranged <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_ranged";
		this.m.Name = "Ranged Weapon";
		this.m.OrderOfAssignment = 3;
		this.m.Min = 0;
		this.m.TooltipPrefix = "Has an aptitude for";
		this.m.Groups = [
			"pg.rf_bow",
			"pg.rf_crossbow",
			"pg.rf_throwing"
		];
	}
});
