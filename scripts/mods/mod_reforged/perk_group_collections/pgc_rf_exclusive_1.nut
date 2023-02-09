::Reforged.PerkGroupCollections.Exclusive_1 <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_exclusive_1";
		this.Name = "Profession";
		this.OrderOfAssignment = 1;
		this.Min = 0;
		this.TooltipPrefix = "%name%";
		this.PerkGroups = [
			"pg.rf_laborer",
			"pg.rf_militia",
			"pg.rf_noble",
			"pg.rf_pauper",
			"pg.rf_raider",
			"pg.rf_soldier",
			"pg.rf_swordmaster",
			"pg.rf_wildling",
			"pg.rf_trapper",
		];
	}
};
