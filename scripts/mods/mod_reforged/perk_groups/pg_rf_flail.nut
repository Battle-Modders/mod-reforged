::Reforged.PerkGroups.Flail <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_flail";
		this.Name = "Flail";
		this.Icon = "ui/perk_groups/rf_flail.png";
		this.FlavorText = [
			"flails"
		];
		this.Tree = [
			["perk.rf_from_all_sides"],
			[],
			["perk.rf_small_target"],
			["perk.mastery.flail"],
			["perk.rf_whirling_death"],
			["perk.head_hunter"],
			["perk.rf_flail_spinner"]
		];
	}
};
