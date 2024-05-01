this.pg_rf_cleaver_enemy <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_cleaver_enemy";
		this.m.Name = "Cleaver";
		this.m.Icon = "ui/perk_groups/rf_cleaver.png";
		this.m.FlavorText = [
			"cleavers"
		];
		this.m.Trees = {
			"default": [
				["perk.crippling_strikes"],
				[],
				[],
				["perk.mastery.cleaver"],
				[],
				["perk.rf_mauler"],
				[]
			]
		};
	}
});
