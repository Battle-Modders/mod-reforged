this.pg_rf_medium_armor <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_medium_armor";
		this.m.Name = "Medium Armor";
		this.m.Icon = "ui/perk_groups/rf_medium_armor.png";
		this.m.FlavorText = [
			"medium armor"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.dodge"],
				["perk.rf_skirmisher"],
				[],
				[],
				["perk.rf_poise"],
				[]
			]
		};
	}
});
