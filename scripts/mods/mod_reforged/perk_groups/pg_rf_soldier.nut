::Reforged.PerkGroups.Soldier <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_soldier";
		this.Name = "Soldier";
		this.Icon = "ui/perk_groups/rf_soldier.png";
		this.FlavorText = [
			"served in the military",
			"has had professional military experience",
			"claims to have served in a professional army"
		];
		this.Tree = [
			[],
			[],
			["perk.rf_exude_confidence"],
			[],
			["perk.rf_pattern_recognition"],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_trained": -1
		};
	}
};
