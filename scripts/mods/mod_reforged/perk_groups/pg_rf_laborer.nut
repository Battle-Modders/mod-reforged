::Reforged.PerkGroups.Laborer <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_laborer";
		this.Name = "Laborer";
		this.Icon = "ui/perk_groups/rf_laborer.png";
		this.FlavorText = [
			"did hard labor to make a living",
			"has strong, calloused hands, just like those of a laborer"
		];
		this.Tree = [
			["perk.rf_fruits_of_labor"],
			["perk.bags_and_belts"],
			[],
			[],
			["perk.rf_wears_it_well"],
			[],
			[]
		];
	}
};
