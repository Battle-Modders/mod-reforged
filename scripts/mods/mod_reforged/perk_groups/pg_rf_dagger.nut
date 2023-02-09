::Reforged.PerkGroups.Dagger <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_dagger";
		this.Name = "Dagger";
		this.Icon = "ui/perk_groups/rf_dagger.png";
		this.FlavorText = [
			"daggers"
		];
		this.Tree = [
			["perk.rf_featherweight"],
			["perk.backstabber"],
			["perk.rf_between_the_ribs"],
			["perk.mastery.dagger"],
			["perk.rf_double_strike"],
			["perk.overwhelm"],
			["perk.rf_swift_stabs"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.5;
	}
};
