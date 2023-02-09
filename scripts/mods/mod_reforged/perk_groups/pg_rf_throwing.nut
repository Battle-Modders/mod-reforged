::Reforged.PerkGroups.Throwing <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_throwing";
		this.Name = "Throwing";
		this.Icon = "ui/perk_groups/rf_throwing.png";
		this.FlavorText = [
			"throwing weapons"
		];
		this.Tree = [
			["perk.rf_momentum"],
			[],
			["perk.rf_hybridization"],
			["perk.mastery.throwing"],
			["perk.rf_opportunist"],
			[],
			["perk.rf_proximity_throwing_specialist"]
		];
	}
};
