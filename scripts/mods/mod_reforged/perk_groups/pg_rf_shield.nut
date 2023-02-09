::Reforged.PerkGroups.Shield <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_shield";
		this.Name = "Shield";
		this.Icon = "ui/perk_groups/rf_shield.png";
		this.FlavorText = [
			"shields"
		];
		this.Tree = [
			["perk.recover"],
			["perk.rf_phalanx"],
			["perk.shield_expert"],
			["perk.rf_line_breaker"],
			[],
			["perk.duelist"],
			["perk.rf_weapon_master"]
		];
	}
};
