this.pg_rf_sturdy <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_sturdy";
		this.m.Name = "Sturdy";
		this.m.Icon = "ui/perk_groups/rf_sturdy.png";
		this.m.FlavorText = [
			"is sturdy",
			"is sturdily built",
			"looks strong and sturdy",
			"is stouthearted and sturdy",
			"is sturdy and robust",
			"seems sturdy",
			"is sturdy as a mountain"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.steel_brow"],
				["perk.taunt"],
				[],
				[],
				[],
				["perk.indomitable"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_power": 1.2
		};
	}
});
