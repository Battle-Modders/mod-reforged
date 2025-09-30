this.pg_rf_crossbow <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_crossbow";
		this.m.Name = "Crossbow";
		this.m.Icon = "ui/perk_groups/rf_crossbow.png";
		this.m.Tree = [
			["perk.rf_steady_brace"],
			[],
			[],
			["perk.mastery.crossbow"],
			["perk.rf_iron_sights"],
			[],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local rSkill = _perkTree.getProjectedAttributesAvg()[::Const.Attributes.RangedSkill];

		if (rSkill >= 80 && rSkill < 90)
		{
			return -1;
		}

		local ret = 1.0;
		return rSkill < 80 ? ret * 0.5 : ret + 0.1 * ::Math.max(0, rSkill - 80);
	}
});
