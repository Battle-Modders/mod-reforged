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
});
