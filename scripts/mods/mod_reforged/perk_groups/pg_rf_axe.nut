this.pg_rf_axe <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_axe";
		this.m.Name = "Axe";
		this.m.Icon = "ui/perk_groups/rf_axe.png";
		this.m.Tree = [
			[],
			["perk.rf_dismantle"],
			[],
			["perk.mastery.axe"],
			[],
			["perk.rf_dismemberment"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.7 + 0.025 * ::Math.max(0, _perkTree.getProjectedAttributesAvg()[::Const.Attributes.MeleeSkill] - 70);
	}
});
