::Reforged.PerkGroups.Sturdy <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_sturdy";
		this.Name = "Sturdy";
		this.Icon = "ui/perk_groups/rf_sturdy.png";
		this.FlavorText = [
			"is sturdy",
			"is sturdily built",
			"looks strong and sturdy",
			"is stouthearted and sturdy",
			"is sturdy and robust",
			"seems sturdy",
			"is sturdy as a mountain"
		];
		this.Tree = [
			["perk.recover"],
			["perk.steel_brow"],
			["perk.taunt"],
			[],
			[],
			["perk.rf_retribution"],
			["perk.indomitable"]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_power": 1.2
		};
	}
};
