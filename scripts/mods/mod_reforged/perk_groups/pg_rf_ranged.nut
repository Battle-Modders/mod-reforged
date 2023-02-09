this.pg_rf_ranged <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_ranged";
		this.m.Name = "Ranged Weapons";
		this.m.Icon = "ui/perk_groups/rf_ranged.png";
		this.m.FlavorText = [
			"ranged weapons"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.bullseye"],
				[],
				[],
				[],
				[],
				[]
			]
		};
	}
});
