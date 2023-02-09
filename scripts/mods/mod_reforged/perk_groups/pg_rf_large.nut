::Reforged.PerkGroups.Large <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_large";
		this.Name = "Large";
		this.Icon = "ui/perk_groups/rf_large.png";
		this.FlavorText = [
			"is large",
			"is large and hulking",
			"has impressively large shoulders",
			"is a large sort",
			"looms large above you",
			"is mountainously large",
			"has large musculature"
		];
		this.Tree = [
			["perk.colossus"],
			["perk.steel_brow"],
			[],
			[],
			[],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_power": 1.2
		};
	}
};
