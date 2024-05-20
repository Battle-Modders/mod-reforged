this.pg_rf_always_1 <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_always_1";
		this.m.Name = "General";
		this.m.FlavorText = [
			""
		];
		this.m.Trees = {
			"default": [
				["perk.bags_and_belts"]
			]
		};
	}
});
