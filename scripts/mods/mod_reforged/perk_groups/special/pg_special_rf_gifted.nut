::Reforged.PerkGroups.Gifted <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_gifted";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_gifted.png";
		this.FlavorText = [
			"Seems naturally gifted for mercenary work!"
		];
		this.Chance = 5;
		this.Tree = [
			["perk.gifted"],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}
};
