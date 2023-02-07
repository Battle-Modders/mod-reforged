this.pg_rf_wildling <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_wildling";
		this.m.Name = "Wildling";
		this.m.Icon = "ui/perk_groups/rf_wildling.png";
		this.m.FlavorText = [
			"hails from the wild",
			"is wild and savage",
			"looks like a feral predator"
		];
		this.m.Trees = {
			"default": [
				["perk.pathfinder"],
				[],
				["perk.rf_savage_strength"],
				[],
				["perk.rf_bestial_vigor"],
				[],
				["perk.rf_feral_rage"]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0,
			"pg.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_talented": 0,
			"pg.rf_trained": 0,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0,
			"pg.rf_sword": 0,
			"pg.rf_ranged": 0,
			"pg.rf_shield": 0
		};
	}
});
