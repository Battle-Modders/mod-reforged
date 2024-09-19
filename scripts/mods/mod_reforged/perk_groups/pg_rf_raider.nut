this.pg_rf_raider <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_raider";
		this.m.Name = "Raider";
		this.m.Icon = "ui/perk_groups/rf_raider.png";
		this.m.Tree = [
			["perk.rf_menacing"],
			["perk.rf_bully"],
			[],
			[],
			[],
			[],
			[]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_vicious": 3
		};
	}
});
