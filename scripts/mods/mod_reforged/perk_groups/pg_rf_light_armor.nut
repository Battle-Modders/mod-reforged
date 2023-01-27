this.pg_rf_light_armor <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_light_armor";
		this.m.Name = "Light Armor";
		this.m.Icon = "ui/perks/perk_29.png"; // nimble icon
		this.m.FlavorText = [
			"light armor"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.dodge"],
				["perk.relentless"],
				[],
				[],
				["perk.nimble"],
				[]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.66;
	}
});
