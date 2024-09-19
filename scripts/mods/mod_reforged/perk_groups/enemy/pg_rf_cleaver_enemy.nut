this.pg_rf_cleaver_enemy <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_cleaver_enemy";
		this.m.Name = "";
		this.m.Icon = "ui/perk_groups/rf_cleaver.png";
		this.m.Tree = [
			["perk.crippling_strikes"],
			[],
			[],
			["perk.mastery.cleaver"],
			[],
			["perk.rf_mauler"],
			[]
		];
	}
});
