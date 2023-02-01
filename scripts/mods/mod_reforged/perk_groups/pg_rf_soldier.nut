this.pg_rf_soldier <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_soldier";
		this.m.Name = "Soldier";
		this.m.Icon = "ui/perk_groups/rf_soldier.png";
		this.m.FlavorText = [
			"served in the military",
			"has had professional military experience",
			"claims to have served in a professional army"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.rf_exude_confidence"],
				[],
				["perk.rf_pattern_recognition"],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": -1
		};
	}
});
