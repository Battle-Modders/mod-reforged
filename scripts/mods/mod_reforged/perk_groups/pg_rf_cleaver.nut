this.pg_rf_cleaver <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_cleaver";
		this.m.Name = "Cleaver";
		this.m.Icon = "ui/perk_groups/rf_cleaver.png";
		this.m.FlavorText = [
			"cleavers"
		];
		this.m.Trees = {
			"default": [
				["perk.crippling_strikes"],
				["perk.rf_sanguinary"],
				[],
				["perk.mastery.cleaver"],
				["perk.rf_swordlike"],
				["perk.rf_bloodbath"],
				["perk.rf_bloodlust"]
			]
		};
	}
});
