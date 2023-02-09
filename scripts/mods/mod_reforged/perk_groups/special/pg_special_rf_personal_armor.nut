::Reforged.PerkGroups.PersonalArmor <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_personal_armor";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_personal_armor.png";
		this.FlavorText = [
			"Knows how to keep good care of his personal armor."
		];
		this.Chance = 0;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			["perk.rf_personal_armor"],
			[]
		];
	}
};
