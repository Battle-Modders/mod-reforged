this.pg_rf_noble <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_noble";
		this.m.Name = "Noble";
		this.m.Icon = "ui/perk_groups/rf_noble.png";
		this.m.Tree = [
			["perk.rf_family_pride"],
			[],
			[],
			[],
			["perk.rf_command"],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_tactician": 2,
			"pg.rf_trained": 1.5
		};
	}
});
