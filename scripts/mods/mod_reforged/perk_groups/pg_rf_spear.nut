::Reforged.PerkGroups.Spear <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_spear";
		this.Name = "Spear";
		this.Icon = "ui/perk_groups/rf_spear.png";
		this.FlavorText = [
			"spears"
		];
		this.Tree = [
			["perk.rf_spear_advantage"],
			[],
			[],
			["perk.mastery.spear"],
			["perk.rf_two_for_one"],
			["perk.rf_through_the_gaps"],
			["perk.rf_king_of_all_weapons"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 1.33;
	}
};
