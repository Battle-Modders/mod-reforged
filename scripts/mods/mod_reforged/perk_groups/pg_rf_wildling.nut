this.pg_rf_wildling <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_wildling";
		this.m.Name = "Wildling";
		this.m.Icon = "ui/perk_groups/rf_wildling.png";
		this.m.Tree = [
			["perk.pathfinder"],
			["perk.rf_bestial_vigor"],
			[],
			[],
			["perk.rf_savage_strength"],
			["perk.rf_feral_rage"],
			[]
		];
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_trained":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_dagger":
			case "pg.rf_ranged":
			case "pg.rf_shield":
			case "pg.special.rf_back_to_basics":
			case "pg.special.rf_discovered_talent":
			case "pg.special.rf_gifted":
			case "pg.special.rf_student":
				return 0;

			case "pg.rf_spear":
				return 0.8;

			case "pg.rf_sword":
				return 0.9;
		}
	}
});
