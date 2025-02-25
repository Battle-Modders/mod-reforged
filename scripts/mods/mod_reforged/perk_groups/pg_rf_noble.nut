this.pg_rf_noble <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_noble";
		this.m.Name = "Noble";
		this.m.Icon = "ui/perk_groups/rf_noble.png";
		this.m.Tree = [
			["perk.rf_family_pride"],
			[],
			[],
			[],
			["perk.rf_command"],
			[],
			[]
		];
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tactician":
				return 2;

			case "pg.rf_trained":
				return 1.5;
		}
	}
});
