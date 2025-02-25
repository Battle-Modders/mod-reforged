this.pg_rf_militia <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_militia";
		this.m.Name = "Militia";
		this.m.Icon = "ui/perk_groups/rf_militia.png";
		this.m.Tree = [
			["perk.rf_phalanx"],
			["perk.rf_strength_in_numbers"],
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
			case "pg.rf_spear":
				return -1;

			case "pg.rf_tactician":
				return 1.5;

			case "pg.rf_trained":
				return 2;
		}
	}
});
