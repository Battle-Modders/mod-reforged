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
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 1.5;
		}
	}
});
