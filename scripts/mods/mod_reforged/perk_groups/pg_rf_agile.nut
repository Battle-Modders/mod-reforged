this.pg_rf_agile <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_agile";
		this.m.Name = "Agile";
		this.m.Icon = "ui/perk_groups/rf_agile.png";
		this.m.FlavorText = [
			"is agile",
			"moves with grace and agility",
			"is naturally agile",
			"is impressively agile",
			"has an agile physique",
			"is agile like a fox",
			"is particularly agile"
		];
		this.m.Trees = {
			"default": [
				["perk.pathfinder"],
				["perk.anticipation"],
				[],
				[],
				["perk.footwork"],
				["perk.rf_fresh_and_furious"],
				["perk.battle_flow"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
});
