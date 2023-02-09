::Reforged.PerkGroupCollections.Armor <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_armor";
		this.Name = "Armor";
		this.OrderOfAssignment = 4;
		this.Min = 2;
		this.TooltipPrefix = "Prefers wearing";
		this.PerkGroups = [
			"pg.rf_light_armor",
			"pg.rf_medium_armor",
			"pg.rf_heavy_armor",
		];
	}
};
