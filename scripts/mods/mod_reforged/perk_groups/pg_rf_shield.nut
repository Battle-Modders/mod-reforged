this.pg_rf_shield <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_shield";
		this.m.Name = "Shield";
		this.m.Icon = "ui/perk_groups/rf_shield.png";
		this.m.FlavorText = [
			"shields"
		];
		this.m.Trees = {
			"default": [
				["perk.recover"],
				["perk.rf_phalanx"],
				["perk.shield_expert"],
				["perk.rf_line_breaker"],
				[],
				["perk.duelist"],
				["perk.rf_weapon_master"]
			]
		};
	}
});
