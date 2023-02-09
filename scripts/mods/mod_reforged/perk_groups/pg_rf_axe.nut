::Reforged.PerkGroups.Axe <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_axe";
		this.Name = "Axe";
		this.Icon = "ui/perk_groups/rf_axe.png";
		this.FlavorText = [
			"axes"
		];
		this.Tree = [
			["perk.rf_shield_splitter"],
			[],
			[],
			["perk.mastery.axe"],
			["perk.rf_between_the_eyes"],
			["perk.rf_heft"],
			["perk.rf_cull"]
		];
	}
};
