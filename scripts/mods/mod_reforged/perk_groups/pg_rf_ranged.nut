this.pg_rf_ranged <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_ranged";
		this.m.Name = "Ranged Combat";
		this.m.Icon = "ui/perk_groups/rf_ranged.png";
		this.m.Tree = [
			[],
			["perk.rf_entrenched"],
			["perk.bullseye"],
			[],
			["perk.rf_nailed_it"],
			["perk.overwhelm"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local ret = 0.0;
		if (_perkTree.hasPerkGroup("pg.rf_bow")) ret += 1.0;
		if (_perkTree.hasPerkGroup("pg.rf_crossbow")) ret += 1.0;

		if (ret != 0 && _perkTree.getProjectedAttributesAvg()[::Const.Attributes.RangedSkill] >= 80)
			return -1;

		if (_perkTree.hasPerkGroup("pg.rf_throwing")) ret += 1.0;

		if (ret == 0)
			return ret;

		local guarantee = true;
		foreach (pgID in ::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon").getGroups())
		{
			if (pgID != "pg.rf_bow" && pgID != "pg.rf_crossbow" && pgID != "pg.rf_throwing" && _perkTree.hasPerkGroup(pgID))
			{
				guarantee = false;
				break;
			}
		}

		if (guarantee)
			return -1;

		local rSkill = _perkTree.getProjectedAttributesAvg()[::Const.Attributes.RangedSkill];

		return rSkill < 75 ? ret * 0.5 : ret + 0.02 * ::Math.max(0, rSkill - 75);
	}
});
