this.pg_rf_soldier <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_soldier";
		this.m.Name = "Soldier";
		this.m.Icon = "ui/perk_groups/rf_soldier.png";
		this.m.Tree = [
			[],
			["perk.rf_exude_confidence"],
			[],
			[],
			["perk.rf_pattern_recognition"],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": -1,
			"pg.special.rf_back_to_basics": 2.5,
			"pg.special.rf_professional": -1
		};
	}
});
