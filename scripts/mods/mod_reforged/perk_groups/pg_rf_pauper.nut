::Reforged.PerkGroups.Pauper <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_pauper";
		this.Name = "Pauper";
		this.Icon = "ui/perk_groups/rf_pauper.png";
		this.FlavorText = [
			"is a dreg of society",
			"looks utterly beaten down",
			"is a pitiful pile of flesh and bones"
		];
		this.Tree = [
			["perk.rf_promised_potential"],
			[],
			[],
			[],
			["perk.rf_trauma_survivor"],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_talented": 0
		};
	}
};
