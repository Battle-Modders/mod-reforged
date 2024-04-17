this.pg_rf_spear <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_spear";
		this.m.Name = "Spear";
		this.m.Icon = "ui/perk_groups/rf_spear.png";
		this.m.FlavorText = [
			"spears"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_spear_advantage"],
				[],
				[],
				["perk.mastery.spear"],
				[],
				["perk.rf_through_the_gaps"],
				["perk.rf_king_of_all_weapons"]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 1.33;
	}
});
