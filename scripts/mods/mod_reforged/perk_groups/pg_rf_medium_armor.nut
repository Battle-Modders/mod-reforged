this.pg_rf_medium_armor <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_medium_armor";
		this.m.Name = "Medium Armor";
		this.m.Icon = "ui/perks/rf_poise.png";
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
