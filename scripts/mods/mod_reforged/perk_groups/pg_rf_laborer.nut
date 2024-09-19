this.pg_rf_laborer <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_laborer";
		this.m.Name = "Laborer";
		this.m.Icon = "ui/perk_groups/rf_laborer.png";
		this.m.Tree = [
			["perk.rf_fruits_of_labor"],
			[],
			[],
			[],
			["perk.rf_wears_it_well"],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": 1.5,
			"pg.rf_vigorous": 1.5
		};
	}
});
