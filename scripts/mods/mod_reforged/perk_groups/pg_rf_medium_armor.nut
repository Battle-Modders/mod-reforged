::Reforged.PerkGroups.MediumArmor <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_medium_armor";
		this.Name = "Medium Armor";
		this.Icon = "ui/perk_groups/rf_medium_armor.png";
		this.FlavorText = [
			"medium armor"
		];
		this.Tree = [
			[],
			["perk.dodge"],
			["perk.rf_skirmisher"],
			[],
			[],
			["perk.rf_poise"],
			[]
		];
	}
};
