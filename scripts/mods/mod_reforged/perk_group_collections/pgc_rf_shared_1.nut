::Reforged.PerkGroupCollections.Shared_1 <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_shared_1";
		this.Name = "Trait";
		this.OrderOfAssignment = 2;
		this.Min = 5;
		this.TooltipPrefix = "He";
		this.PerkGroups = [
			"pg.rf_agile",
			"pg.rf_devious",
			"pg.rf_fast",
			"pg.rf_large",
			"pg.rf_leadership",
			"pg.rf_resilient",
			"pg.rf_sturdy",
			"pg.rf_tactician",
			"pg.rf_talented",
			"pg.rf_trained",
			"pg.rf_unstoppable",
			"pg.rf_vicious",
		];
	}
};
