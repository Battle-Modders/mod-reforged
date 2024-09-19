this.pg_rf_cleaver <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_cleaver";
		this.m.Name = "Cleaver";
		this.m.Icon = "ui/perk_groups/rf_cleaver.png";
		this.m.Tree = [
			[],
			["perk.rf_sanguinary"],
			[],
			["perk.mastery.cleaver"],
			[],
			["perk.rf_mauler"],
			[]
		];
	}
});
