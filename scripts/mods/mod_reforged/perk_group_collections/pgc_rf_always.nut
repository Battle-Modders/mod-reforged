::Reforged.PerkGroupCollections.Always <- class extends DynamicPerks.Class.PerkGroupCollection
{
	constructor()
	{
		this.ID = "pgc.rf_always";
		this.Name = "General";
		this.OrderOfAssignment = 1;
		this.Min = 1;
		this.TooltipPrefix = "";
		this.PerkGroups = [
			"pg.rf_always_1"
		];
	}
};
