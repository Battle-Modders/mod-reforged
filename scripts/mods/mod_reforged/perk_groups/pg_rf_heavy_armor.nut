this.pg_rf_heavy_armor <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_heavy_armor";
		this.m.Name = "Heavy Armor";
		this.m.Icon = "ui/perks/perk_03.png"; // battle forged icon
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
		this.m.PerkTreeMultipliers = {
			"self": 0.5
		};
	}
});
