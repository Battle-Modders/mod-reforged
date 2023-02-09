::Reforged.PerkGroups.Trained <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_trained";
		this.Name = "Trained";
		this.Icon = "ui/perk_groups/rf_trained.png";
		this.FlavorText = [
			"is well trained",
			"has great training",
			"is drilled and trained",
			"has combat training",
			"has trained a great deal",
			"has been trained by someone skillful",
			"is trained and disciplined",
			"has genuine training"
		];
		this.Tree = [
			["perk.fast_adaption"],
			[],
			["perk.rotation"],
			["perk.rf_vigilant"],
			["perk.underdog"],
			["perk.rf_finesse"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.75;
	}
};
