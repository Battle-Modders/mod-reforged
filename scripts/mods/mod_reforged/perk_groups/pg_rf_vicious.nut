this.pg_rf_vicious <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_vicious";
		this.m.Name = "Vicious";
		this.m.Icon = "ui/perk_groups/rf_vicious.png";
		this.m.FlavorText = [
			"is vicious",
			"seems fiendishly vicious",
			"is ferociously vicious",
			"is brutal and vicious",
			"appears diabolically vicious",
			"is beastially vicious",
			"enjoys vicious butchery"
		];
		this.m.Trees = {
			"default": [
				["perk.crippling_strikes"],
				["perk.coup_de_grace"],
				["perk.taunt"],
				[],
				["perk.berserk"],
				["perk.rf_battle_fervor"],
				["perk.fearsome"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_shield": 0.8
		};
	}
});
