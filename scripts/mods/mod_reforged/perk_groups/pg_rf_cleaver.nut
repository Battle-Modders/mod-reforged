::Reforged.PerkGroups.Cleaver <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_cleaver";
		this.Name = "Cleaver";
		this.Icon = "ui/perk_groups/rf_cleaver.png";
		this.FlavorText = [
			"cleavers"
		];
		this.Tree = [
			["perk.crippling_strikes"],
			["perk.rf_sanguinary"],
			[],
			["perk.mastery.cleaver"],
			["perk.rf_swordlike"],
			["perk.rf_bloodbath"],
			["perk.rf_bloodlust"]
		];
	}
};
