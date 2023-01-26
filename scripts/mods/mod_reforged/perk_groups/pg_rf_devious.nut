this.pg_rf_devious <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_devious";
		this.m.Name = "Devious";
		this.m.Icon = "ui/perks/rf_sneak_attack.png";
		this.m.FlavorText = [
			"is devious",
			"strikes you as devious",
			"has a devious appearance",
			"is insincere and devious",
			"is devious and sneaky",
			"carries himself deviously",
			"is shrewd and devious"
		];
		this.m.Trees = {
			"default": [
				["perk.pathfinder"],
				["perk.backstabber"],
				[],
				["perk.rf_ghostlike"],
				["perk.rf_sneak_attack"],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"self": 0.66
		};
	}
});
