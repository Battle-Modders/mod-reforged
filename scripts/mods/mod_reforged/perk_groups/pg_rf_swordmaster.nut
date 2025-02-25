this.pg_rf_swordmaster <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_swordmaster";
		this.m.Name = "Swordmaster";
		this.m.Icon = "ui/perk_groups/rf_swordmaster.png";
		this.m.Tree = [
			[],
			[],
			[],
			[
				"perk.rf_swordmaster_blade_dancer",
				"perk.rf_swordmaster_metzger",
				"perk.rf_swordmaster_juggernaut",
				"perk.rf_swordmaster_versatile_swordsman",
				"perk.rf_swordmaster_precise",
				"perk.rf_swordmaster_reaper"
			],
			[],
			[],
			[]
		];
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_sword":
				return -1;

			case "pg.rf_ranged":
				return 0;
		}
	}
});
