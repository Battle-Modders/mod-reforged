this.pg_rf_agile <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_agile";
		this.m.Name = "Agile";
		this.m.Icon = "ui/perk_groups/rf_agile.png";
		this.m.Tree = [
			["perk.pathfinder"],
			["perk.anticipation"],
			[],
			["perk.rf_death_dealer"],
			["perk.footwork"],
			["perk.head_hunter"],
			["perk.battle_flow"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
});
