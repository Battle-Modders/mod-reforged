this.pg_rf_agile <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_agile";
		this.m.Name = "Agile";
		this.m.Icon = "ui/perk_groups/rf_agile.png";
		this.m.Tree = [
			["perk.pathfinder"],
			["perk.anticipation"],
			[],
			["perk.rf_death_dealer"],
			["perk.footwork"],
			["perk.head_hunter"],
			["perk.battle_flow"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 1.0 : ::Math.max(1, talents[::Const.Attributes.RangedDefense]) * 1.2;
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_swift":
				return 1.2;
		}
	}
});
