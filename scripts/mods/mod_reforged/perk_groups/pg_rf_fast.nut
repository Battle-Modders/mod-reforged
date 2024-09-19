this.pg_rf_fast <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_fast";
		this.m.Name = "Fast";
		this.m.Icon = "ui/perk_groups/rf_fast.png";
		this.m.Tree = [
			["perk.nine_lives"],
			["perk.quick_hands"],
			[],
			["perk.rf_dynamic_duo"],
			["perk.rf_combo"],
			["perk.overwhelm"],
			["perk.rf_calculated_strikes"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
});
