::Reforged.PerkGroups.RisingStar <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_rising_star";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_rising_star.png";
		this.FlavorText = [
			"Has the talent to rise and shine above all others!"
		];
		this.Chance = 2;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_rising_star"]
		];
	}
};
