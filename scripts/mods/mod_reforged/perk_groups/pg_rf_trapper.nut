::Reforged.PerkGroups.Trapper <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_trapper";
		this.Name = "Trapper";
		this.Icon = "ui/perk_groups/rf_trapper.png";
		this.FlavorText = [
			"has experience in trapping and using nets"
		];
		this.Tree = [
			[],
			["perk.rf_trip_artist"],
			[],
			["perk.rf_offhand_training"],
			["perk.rf_angler"],
			[],
			["perk.rf_kingfisher"]
		];
	}
};
