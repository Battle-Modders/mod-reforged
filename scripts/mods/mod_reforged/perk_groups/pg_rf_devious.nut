::Reforged.PerkGroups.Devious <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_devious";
		this.Name = "Devious";
		this.Icon = "ui/perk_groups/rf_devious.png";
		this.FlavorText = [
			"is devious",
			"strikes you as devious",
			"has a devious appearance",
			"is insincere and devious",
			"is devious and sneaky",
			"carries himself deviously",
			"is shrewd and devious"
		];
		this.Tree = [
			["perk.pathfinder"],
			["perk.backstabber"],
			[],
			["perk.rf_ghostlike"],
			["perk.rf_sneak_attack"],
			[],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.66;
	}
};
