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
			["perk.rf_calculated_strikes"],
			["perk.overwhelm"],
			["perk.rf_combo"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 1.0 : ::Math.max(1, talents[::Const.Attributes.Initiative]) * 1.2;
	}
});
