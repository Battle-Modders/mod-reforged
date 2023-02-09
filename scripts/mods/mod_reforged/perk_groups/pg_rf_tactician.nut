::Reforged.PerkGroups.Tactician <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_tactician";
		this.Name = "Tactician";
		this.Icon = "ui/perk_groups/rf_tactician.png";
		this.FlavorText = [
			"is skilled in battlefield tactics",
			"claims to have studied battlefield tactics",
			"has a tactical and calculating mind"
		];
		this.Tree = [
			[],
			[],
			["perk.rf_shield_sergeant"],
			["perk.rf_onslaught"],
			["perk.rf_hold_steady"],
			[],
			["perk.rf_blitzkrieg"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
};
