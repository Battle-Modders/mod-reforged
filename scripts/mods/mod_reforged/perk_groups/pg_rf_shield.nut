this.pg_rf_shield <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_shield";
		this.m.Name = "Shield";
		this.m.Icon = "ui/perk_groups/rf_shield.png";
		this.m.Tree = [
			["perk.rf_exploit_opening"],
			["perk.rf_phalanx"],
			["perk.shield_expert"],
			["perk.rf_line_breaker"],
			["perk.rf_rebuke"],
			["perk.duelist"],
			[]
		];
	}
});
