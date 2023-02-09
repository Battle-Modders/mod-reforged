::Reforged.PerkGroups.Leadership <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_leadership";
		this.Name = "Leadership";
		this.Icon = "ui/perk_groups/rf_leadership.png";
		this.FlavorText = [
			"is a natural born leader",
			"has an aura of leadership",
			"seems like a capable leader"
		];
		this.Tree = [
			[],
			["perk.rally_the_troops"],
			["perk.fortified_mind"],
			[],
			[],
			[],
			["perk.inspiring_presence"]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_polearm": -1
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
};
