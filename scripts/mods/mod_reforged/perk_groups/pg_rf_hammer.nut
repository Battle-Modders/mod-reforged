this.pg_rf_hammer <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_hammer";
		this.m.Name = "Hammer";
		this.m.Icon = "ui/perk_groups/rf_hammer.png";
		this.m.Tree = [
			[],
			[],
			["perk.rf_rattle"],
			["perk.mastery.hammer"],
			[],
			["perk.rf_deep_impact"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.7 + 0.025 * ::Math.max(0, _perkTree.getProjectedAttributesAvg()[::Const.Attributes.MeleeSkill] - 70);
	}
});
