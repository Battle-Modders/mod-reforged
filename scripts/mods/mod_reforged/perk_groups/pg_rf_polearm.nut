this.pg_rf_polearm <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_polearm";
		this.m.Name = "Polearm";
		this.m.Icon = "ui/perk_groups/rf_polearm.png";
		this.m.Tree = [
			[],
			[],
			["perk.rf_leverage"],
			["perk.mastery.polearm"],
			[],
			[],
			["perk.rf_long_reach"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local ret = 0.7 + 0.025 * ::Math.max(0, _perkTree.getProjectedAttributesAvg()[::Const.Attributes.MeleeSkill] - 70);
		return ret + ::Math.maxf(0.0, 1.5 - 0.06 * _perkTree.getProjectedAttributesAvg()[::Const.Attributes.MeleeDefense]);
	}
});
