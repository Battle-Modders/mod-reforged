this.pg_rf_ranged <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_ranged";
		this.m.Name = "Ranged Weapons";
		this.m.Icon = "ui/perk_groups/rf_ranged.png";
		this.m.FlavorText = [
			"ranged weapons"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.bullseye"],
				["perk.rf_entrenched"],
				[],
				[],
				[],
				[]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		local ret = 0;
		if (_perkTree.hasPerkGroup("pg.rf_bow")) ret += 1.0;
		if (_perkTree.hasPerkGroup("pg.rf_crossbow")) ret += 1.0;
		if (_perkTree.hasPerkGroup("pg.rf_throwing")) ret += 1.0;

		if (ret == 0)
			return ret;

		local talents = _perkTree.getActor().getTalents();
		if (talents.len() != 0) ret += talents[::Const.Attributes.RangedSkill]; // += is intended

		return ret;
	}
});
