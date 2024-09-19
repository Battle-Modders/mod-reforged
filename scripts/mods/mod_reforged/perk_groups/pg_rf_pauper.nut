this.pg_rf_pauper <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_pauper";
		this.m.Name = "Pauper";
		this.m.Icon = "ui/perk_groups/rf_pauper.png";
		this.m.Tree = [
			["perk.rf_promised_potential"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_discovered_talent": 0,
			"pg.special.rf_gifted": 0,
			"pg.special.rf_rising_star": 0,
			"pg.special.rf_student": 0
		};
	}
});
