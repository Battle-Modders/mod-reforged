this.pg_rf_laborer <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_laborer";
		this.m.Name = "Laborer";
		this.m.Icon = "ui/perk_groups/rf_laborer.png";
		this.m.FlavorText = [
			"did hard labor to make a living",
			"has strong, calloused hands, just like those of a laborer"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_fruits_of_labor"],
				["perk.bags_and_belts"],
				[],
				[],
				["perk.rf_wears_it_well"],
				[],
				[]
			]
		};
	}
});
