this.pg_rf_bow <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_bow";
		this.m.Name = "Bow";
		this.m.Icon = "ui/perk_groups/rf_bow.png";
		this.m.Tree = [
			["perk.rf_target_practice"],
			[],
			[],
			["perk.mastery.bow"],
			[],
			[],
			["perk.rf_trick_shooter"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_ranged": 1.5
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.33;
	}
});
