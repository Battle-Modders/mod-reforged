this.pg_rf_raider <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_raider";
		this.m.Name = "Raider";
		this.m.Icon = "ui/perks/rf_bully.png";
		this.m.FlavorText = [
			"raided villages and caravans",
			"is a well-known raider and looter in this area"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_menacing"],
				[],
				[],
				[],
				[],
				["perk.rf_bully"],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_vicious": 3
		};
	}
});
