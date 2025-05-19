this.pg_special_rf_fencer <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_fencer";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_fencer.png";
		this.m.Chance = 100;
		this.m.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_fencer"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_sword") || (!_perkTree.hasPerkGroup("pg.rf_light_armor") && !_perkTree.hasPerkGroup("pg.rf_medium_armor")))
			return 0;

		local p = _perkTree.RF_getProjectedAttributesAvg();
		if (p[::Const.Attributes.Initiative] < 130)
			return 0;

		if (p[::Const.Attributes.Initiative] + p[::Const.Attributes.MeleeSkill] > 238)
			return -1;

		return 0;
	}
});
