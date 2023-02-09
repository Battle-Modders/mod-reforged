::Reforged.PerkGroupCollections.Fighting_style <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_fighting_style";
		this.Name = "Fighting Style";
		this.OrderOfAssignment = 5;
		this.Min = 2;
		this.TooltipPrefix = "Prefers using";
		this.PerkGroups = [
			"pg.rf_power",
			"pg.rf_ranged",
			"pg.rf_shield",
			"pg.rf_swift"
		];
	}
};
