::Reforged.PerkGroups.Talented <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_talented";
		this.Name = "Talented";
		this.Icon = "ui/perk_groups/rf_talented.png";
		this.FlavorText = [
			"is talented",
			"lives with talented ease",
			"has unparalleled talent",
			"is bright and talented",
			"is talented in many ways",
			"is talented beyond belief",
			"succeeds easily and with talent"
		];
		this.Tree = [
			["perk.student"],
			[],
			[],
			["perk.rf_discovered_talent"],
			["perk.rf_back_to_basics"],
			[],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.1;
	}
};
