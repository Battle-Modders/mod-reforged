::Reforged.PerkGroups.Sword <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_sword";
		this.Name = "Sword";
		this.Icon = "ui/perk_groups/rf_sword.png";
		this.FlavorText = [
			"swords"
		];
		this.Tree = [
			[],
			["perk.rf_exploit_opening"],
			["perk.rf_fluid_weapon"],
			["perk.mastery.sword"],
			["perk.rf_tempo"],
			["perk.rf_kata"],
			["perk.rf_en_garde"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 1.2;
	}
};
