this.pgc_rf_weapon <- ::inherit(::DynamicPerks.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_weapon";
		this.m.Name = "Weapon";
		this.m.OrderOfAssignment = 3;
		this.m.Min = 3;
		this.m.TooltipPrefix = "Has an aptitude for";
		this.m.Groups = [
			"pg.rf_axe",
			"pg.rf_bow",
			"pg.rf_cleaver",
			"pg.rf_crossbow",
			"pg.rf_dagger",
			"pg.rf_flail",
			"pg.rf_hammer",
			"pg.rf_mace",
			"pg.rf_polearm",
			"pg.rf_spear",
			"pg.rf_sword",
			"pg.rf_throwing"
		];
	}
});
