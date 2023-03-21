this.pg_special_rf_weapon_master <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_weapon_master";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_weapon_master.png";
		this.m.FlavorText = [
			"Has the talent to become a master of many weapons."
		];
		this.m.Chance = 100;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_weapon_master"]
			]
		};
	}

	function getMultiplier( _perkTree )
	{
		if (_perkTree.hasPerkGroup("pg.rf_throwing"))
			return 1.0;

		if (_perkTree.hasPerkGroup("pg.rf_swift") && _perkTree.hasPerkGroup("pg.rf_shield"))
			return 1.0;

		return 0;
	}
});
