::Reforged.PerkGroups.Resilient <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_resilient";
		this.Name = "Resilent";
		this.Icon = "ui/perk_groups/rf_resilient.png";
		this.FlavorText = [
			"is unnaturally resilient",
			"is stubbornly resilient",
			"is staunchly resilient",
			"has a resilient will",
			"resiliently persists",
			"seems unwaveringly resilient",
			"is resilient beyond measure"
		];
		this.Tree = [
			["perk.nine_lives"],
			["perk.hold_out"],
			["perk.fortified_mind"],
			[],
			["perk.rf_survival_instinct"],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_shield": 1.2
		};
	}
};
