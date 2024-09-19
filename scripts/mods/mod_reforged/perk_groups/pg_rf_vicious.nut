this.pg_rf_vicious <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_vicious";
		this.m.Name = "Vicious";
		this.m.Icon = "ui/perk_groups/rf_vicious.png";
		this.m.Tree = [
			["perk.rf_small_target"],
			["perk.backstabber"],
			["perk.rf_between_the_eyes"],
			["perk.rf_battle_fervor"],
			["perk.berserk"],
			[],
			["perk.fearsome"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_shield": 0.8
		};
	}
});
