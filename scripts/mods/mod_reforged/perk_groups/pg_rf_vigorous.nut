this.pg_rf_vigorous <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_vigorous";
		this.m.Name = "Vigorous";
		this.m.Icon = "ui/perk_groups/rf_vigorous.png";
		this.m.Tree = [
			["perk.rf_survival_instinct"],
			["perk.steel_brow"],
			["perk.fortified_mind"],
			["perk.rf_decisive"],
			[],
			["perk.rf_fresh_and_furious"],
			["perk.indomitable"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 1.0 : ::Math.max(1, talents[::Const.Attributes.Fatigue]) * 1.2;
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_shield":
				return 1.2;
		}
	}
});
