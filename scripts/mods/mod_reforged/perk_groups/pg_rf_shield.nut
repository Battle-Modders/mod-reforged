this.pg_rf_shield <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_shield";
		this.m.Name = "Shield";
		this.m.Icon = "ui/perk_groups/rf_shield.png";
		this.m.Tree = [
			["perk.rf_exploit_opening"],
			["perk.rf_phalanx"],
			["perk.shield_expert"],
			["perk.rf_line_breaker"],
			["perk.rf_rebuke"],
			["perk.duelist"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local canGet = false;
		foreach (pgID in ::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon").getGroups())
		{
			if (pgID != "pg.rf_bow" && pgID != "pg.rf_crossbow" && pgID != "pg.rf_throwing" && pgID != "pg.rf_polearm" && _perkTree.hasPerkGroup(pgID))
			{
				canGet = true;
				break;
			}
		}

		if (!canGet)
			return 0;

		return 1.5 - 0.02 * ::Math.max(0, _perkTree.getProjectedAttributesAvg()[::Const.Attributes.MeleeDefense] - 5);
	}
});
