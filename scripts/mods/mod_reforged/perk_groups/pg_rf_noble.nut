::Reforged.PerkGroups.Noble <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_noble";
		this.Name = "Noble";
		this.Icon = "ui/perk_groups/rf_noble.png";
		this.FlavorText = [
			"is of noble birth",
			"hails from a noble family",
			"has noble blood in his veins"
		];
		this.Tree = [
			[],
			["perk.rf_family_pride"],
			[],
			[],
			[],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_trained": 1.5
		};
	}
};
