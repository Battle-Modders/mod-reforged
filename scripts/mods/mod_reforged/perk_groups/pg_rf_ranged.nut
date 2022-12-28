this.pg_rf_ranged <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_ranged";
		this.m.Name = "Ranged Weapons";
		this.m.FlavorText = [
			"ranged weapons"
		];
		this.m.Trees = {
			"default": [
				["perk.bags_and_belts"],
				["perk.bullseye"],
				[],
				[],
				[],
				["perk.rf_ballistics"],
				[]
			]
		};
	}
});
