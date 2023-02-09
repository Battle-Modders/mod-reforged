::Reforged.PerkGroups.Bow <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_bow";
		this.Name = "Bow";
		this.Icon = "ui/perk_groups/rf_bow.png";
		this.FlavorText = [
			"bows"
		];
		this.Tree = [
			["perk.rf_target_practice"],
			[],
			[],
			["perk.mastery.bow"],
			["perk.rf_flaming_arrows"],
			["perk.rf_eyes_up"],
			["perk.rf_hip_shooter"]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_ranged": 1.5
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.33;
	}
};
