this.pg_rf_always_1 <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_always_1";
		this.m.Name = "General Perks";
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
