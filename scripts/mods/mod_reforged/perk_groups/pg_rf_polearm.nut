::Reforged.PerkGroups.Polearm <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_polearm";
		this.Name = "Polearm";
		this.Icon = "ui/perk_groups/rf_polearm.png";
		this.FlavorText = [
			"polearms"
		];
		this.Tree = [
			[],
			["perk.rf_bolster"],
			["perk.rf_leverage"],
			["perk.mastery.polearm"],
			["perk.rf_intimidate"],
			["perk.rf_long_reach"],
			["perk.rf_follow_up"]
		];
	}
};
