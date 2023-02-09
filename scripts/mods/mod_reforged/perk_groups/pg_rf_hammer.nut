::Reforged.PerkGroups.Hammer <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_hammer";
		this.Name = "Hammer";
		this.Icon = "ui/perk_groups/rf_hammer.png";
		this.FlavorText = [
			"hammers"
		];
		this.Tree = [
			["perk.crippling_strikes"],
			[],
			["perk.rf_internal_hemorrhage"],
			["perk.mastery.hammer"],
			[],
			["perk.rf_deep_impact"],
			["perk.rf_dent_armor"]
		];
	}
};
