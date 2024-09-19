this.pg_rf_always_1 <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_always_1";
		this.m.Name = "General";
		this.m.Icon = "ui/perk_groups/rf_always_1.png";
		this.m.Tree = [
			["perk.bags_and_belts"]
		];
	}
});
