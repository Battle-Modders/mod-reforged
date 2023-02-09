::Reforged.PerkGroups.Crossbow <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_crossbow";
		this.Name = "Crossbow";
		this.Icon = "ui/perk_groups/rf_crossbow.png";
		this.FlavorText = [
			"crossbows"
		];
		this.Tree = [
			["perk.rf_power_shot"],
			["perk.rf_entrenched"],
			[],
			["perk.mastery.crossbow"],
			["perk.rf_iron_sights"],
			["perk.rf_muscle_memory"],
			["perk.rf_take_aim"]
		];
	}
};
