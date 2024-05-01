this.pg_rf_dagger <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_dagger";
		this.m.Name = "Dagger";
		this.m.Icon = "ui/perk_groups/rf_dagger.png";
		this.m.FlavorText = [
			"daggers"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_between_the_ribs"],
				[],
				[],
				["perk.mastery.dagger"],
				[],
				[],
				["perk.rf_swift_stabs"]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.5;
	}
});
