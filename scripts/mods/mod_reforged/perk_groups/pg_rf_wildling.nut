::Reforged.PerkGroups.Wildling <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_wildling";
		this.Name = "Wildling";
		this.Icon = "ui/perk_groups/rf_wildling.png";
		this.FlavorText = [
			"hails from the wild",
			"is wild and savage",
			"looks like a feral predator"
		];
		this.Tree = [
			["perk.pathfinder"],
			[],
			["perk.rf_savage_strength"],
			[],
			["perk.rf_bestial_vigor"],
			[],
			["perk.rf_feral_rage"]
		];
		this.PerkTreeMultipliers = {
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
};
