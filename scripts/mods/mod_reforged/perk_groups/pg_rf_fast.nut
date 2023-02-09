::Reforged.PerkGroups.Fast <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_fast";
		this.Name = "Fast";
		this.Icon = "ui/perk_groups/rf_fast.png";
		this.FlavorText = [
			"is fast",
			"runs fast",
			"is fast like a flash",
			"has fast feet",
			"maneuvers fast",
			"has fast steps",
			"is a fast sprinter"
		];
		this.Tree = [
			[],
			["perk.quick_hands"],
			["perk.relentless"],
			[],
			[],
			["perk.overwhelm"],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
};
