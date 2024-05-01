this.pg_rf_sword <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_sword";
		this.m.Name = "Sword";
		this.m.Icon = "ui/perk_groups/rf_sword.png";
		this.m.FlavorText = [
			"swords"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.rf_tempo"],
				["perk.mastery.sword"],
				[],
				[],
				["perk.rf_en_garde"]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 1.2;
	}
});
