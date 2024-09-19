this.pg_rf_knave <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_knave";
		this.m.Name = "Knave";
		this.m.Icon = "ui/perk_groups/rf_knave.png";
		this.m.Tree = [
			["perk.rf_tricksters_purses"],
			["perk.rf_cheap_trick"],
			[],
			["perk.rf_ghostlike"],
			[],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_dagger": -1
		};
	}
});
