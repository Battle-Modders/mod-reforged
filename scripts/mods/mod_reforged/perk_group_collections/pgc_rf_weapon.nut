::Reforged.PerkGroupCollections.Weapon <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_weapon";
		this.Name = "Weapon";
		this.OrderOfAssignment = 3;
		this.Min = 4;
		this.TooltipPrefix = "Has an aptitude for";
		this.PerkGroups = [
			"pg.rf_axe",
			"pg.rf_bow",
			"pg.rf_cleaver",
			"pg.rf_crossbow",
			"pg.rf_dagger",
			"pg.rf_flail",
			"pg.rf_hammer",
			"pg.rf_mace",
			"pg.rf_polearm",
			"pg.rf_spear",
			"pg.rf_sword",
			"pg.rf_throwing"
		];
	}
};
