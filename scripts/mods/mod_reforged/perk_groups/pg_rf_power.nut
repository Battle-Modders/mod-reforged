::Reforged.PerkGroups.Power <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_power";
		this.Name = "Powerful Strikes";
		this.Icon = "ui/perk_groups/rf_power.png";
		this.FlavorText = [
			"powerful weapons"
		];
		this.Tree = [
			["perk.recover"],
			["perk.rf_vigorous_assault"],
			["perk.rotation"],
			["perk.rf_death_dealer"],
			["perk.rf_formidable_approach"],
			["perk.rf_sweeping_strikes"],
			[]
		];
	}
};
