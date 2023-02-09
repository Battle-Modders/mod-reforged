::Reforged.PerkGroups.Unstoppable <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_unstoppable";
		this.Name = "Unstoppable";
		this.Icon = "ui/perk_groups/rf_unstoppable.png";
		this.FlavorText = [
			"seems unstoppable",
			"lifts weights unstoppably",
			"seems unstoppably resolute",
			"acts unstoppable",
			"has unstoppable stamina",
			"is unstoppably strong"
		];
		this.Tree = [
			["perk.adrenaline"],
			[],
			[],
			["perk.rf_the_rush_of_battle"],
			["perk.lone_wolf"],
			["perk.rf_unstoppable"],
			["perk.killing_frenzy"]
		];
	}
};
