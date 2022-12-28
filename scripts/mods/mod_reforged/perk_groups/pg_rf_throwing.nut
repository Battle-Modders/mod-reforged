this.pg_rf_throwing <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_throwing";
		this.m.Name = "Throwing";
		this.m.FlavorText = [
			"throwing weapons"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_momentum"],
				[],
				["perk.rf_hybridization"],
				["perk.mastery.throwing"],
				["perk.rf_opportunist"],
				[],
				["perk.rf_proximity_throwing_specialist"]
			]
		};
	}
});
