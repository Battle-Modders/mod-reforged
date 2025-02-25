this.pg_rf_soldier <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_soldier";
		this.m.Name = "Soldier";
		this.m.Icon = "ui/perk_groups/rf_soldier.png";
		this.m.Tree = [
			[],
			["perk.rf_exude_confidence"],
			[],
			[],
			["perk.rf_pattern_recognition"],
			[],
			[]
		];
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_trained":
			case "pg.special.rf_professional":
				return -1;

			case "pg.special.rf_back_to_basics":
				return 2.5;
		}
	}
});
