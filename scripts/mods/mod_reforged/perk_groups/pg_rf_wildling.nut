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
				["perk.rf_bestial_vigor"],
				[],
				[],
				["perk.rf_savage_strength"],
				["perk.rf_feral_rage"],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_trained": 0,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0.8,
			"pg.rf_sword": 0.9,
			"pg.rf_ranged": 0,
			"pg.rf_shield": 0,
			"pg.special.rf_back_to_basics": 0,
			"pg.special.rf_discovered_talent": 0,
			"pg.special.rf_gifted": 0,
			"pg.special.rf_student": 0
		};
	}
});
