::Reforged.PerkGroups.Mace <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_mace";
		this.Name = "Mace";
		this.Icon = "ui/perk_groups/rf_mace.png";
		this.FlavorText = [
			"maces"
		];
		this.Tree = [
			["perk.rf_rattle"],
			[],
			["perk.rf_bear_down"],
			["perk.mastery.mace"],
			["perk.rf_concussive_strikes"],
			[],
			["perk.rf_bone_breaker"]
		];
	}
};
