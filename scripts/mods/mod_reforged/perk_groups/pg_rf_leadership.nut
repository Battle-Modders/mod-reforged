this.pg_rf_leadership <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_leadership";
		this.m.Name = "Leadership";
		this.m.Icon = "ui/perk_groups/rf_leadership.png";
		this.m.FlavorText = [
			"is a natural born leader",
			"has an aura of leadership",
			"seems like a capable leader"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rally_the_troops"],
				["perk.fortified_mind"],
				[],
				["perk.rf_command"],
				[],
				["perk.inspiring_presence"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_polearm": -1
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
});
