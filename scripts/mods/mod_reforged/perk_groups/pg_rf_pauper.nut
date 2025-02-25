this.pg_rf_pauper <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_pauper";
		this.m.Name = "Pauper";
		this.m.Icon = "ui/perk_groups/rf_pauper.png";
		this.m.Tree = [
			["perk.rf_promised_potential"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_discovered_talent":
			case "pg.special.rf_gifted":
			case "pg.special.rf_rising_star":
			case "pg.special.rf_student":
				return 0;
		}
	}
});
