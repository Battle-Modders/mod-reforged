this.pg_rf_heavy_armor <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_heavy_armor";
		this.m.Name = "Heavy Armor";
		this.m.Icon = "ui/perk_groups/rf_heavy_armor.png";
		this.m.FlavorText = [
			"heavy armor"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.brawny"],
				[],
				["perk.rf_bulwark"],
				["perk.battle_forged"],
				[]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.5;
	}
});
