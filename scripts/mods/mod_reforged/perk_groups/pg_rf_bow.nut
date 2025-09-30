this.pg_rf_bow <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_bow";
		this.m.Name = "Bow";
		this.m.Icon = "ui/perk_groups/rf_bow.png";
		this.m.Tree = [
			["perk.rf_target_practice"],
			[],
			[],
			["perk.mastery.bow"],
			[],
			[],
			["perk.rf_trick_shooter"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local rSkill = _perkTree.getProjectedAttributesAvg()[::Const.Attributes.RangedSkill];

		if (rSkill >= 90)
		{
			return -1;
		}

		local ret = 0.8;
		return rSkill < 80 ? ret * 0.5 : ret + 0.2 * ::Math.max(0, rSkill - 80);
	}
});
