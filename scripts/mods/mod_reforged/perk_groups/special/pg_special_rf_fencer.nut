this.pg_special_rf_fencer <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_fencer";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_fencer.png";
		this.m.Chance = 25;
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

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_sword"))
			return 0;

		local p = _perkTree.getProjectedAttributesAvg();
		local initiative = p[::Const.Attributes.Initiative] - 150;
		local meleeSkill = p[::Const.Attributes.MeleeSkill] - 85;
		if (initiative < 0 || meleeSkill < 0)
			return 0;

		return 1.0 + (initiative + meleeSkill) * 0.05;
	}
});
