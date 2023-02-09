::Reforged.PerkGroups.Professional <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_professional";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_professional.png";
		this.FlavorText = [
			"Carries himself with the grace of a professional soldier."
		];
		this.Chance = 0;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_professional"]
		];
	}
};
