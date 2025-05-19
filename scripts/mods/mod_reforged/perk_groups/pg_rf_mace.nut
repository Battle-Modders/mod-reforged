this.pg_rf_mace <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_mace";
		this.m.Name = "Mace";
		this.m.Icon = "ui/perk_groups/rf_mace.png";
		this.m.Tree = [
			[],
			["perk.rf_concussive_strikes"],
			[],
			["perk.mastery.mace"],
			[],
			[],
			["perk.rf_bone_breaker"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.6 + 0.02 * ::Math.max(0, _perkTree.RF_getProjectedAttributesAvg()[::Const.Attributes.MeleeSkill] - 70);
	}
});
