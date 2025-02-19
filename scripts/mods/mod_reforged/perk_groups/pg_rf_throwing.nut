this.pg_rf_throwing <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_throwing";
		this.m.Name = "Throwing";
		this.m.Icon = "ui/perk_groups/rf_throwing.png";
		this.m.Tree = [
			[],
			[],
			["perk.rf_hybridization"],
			["perk.mastery.throwing"],
			["perk.rf_opportunist"],
			[],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local ret = 1.3;
		local rSkill = _perkTree.getProjectedAttributesAvg()[::Const.Attributes.RangedSkill];

		return rSkill < 70 ? ret * 0.5 : ret - 0.03 * ::Math.max(0, rSkill - 70);
	}
});
