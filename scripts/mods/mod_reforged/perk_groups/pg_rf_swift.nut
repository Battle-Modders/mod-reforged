this.pg_rf_swift <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_swift";
		this.m.Name = "Swift Strikes";
		this.m.Icon = "ui/perk_groups/rf_swift.png";
		this.m.Tree = [
			["perk.fast_adaption"],
			["perk.rf_vigorous_assault"],
			[],
			["perk.rf_offhand_training"],
			["perk.rf_double_strike"],
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

		return canGet ? 1.0 : 0.0;
	}
});
