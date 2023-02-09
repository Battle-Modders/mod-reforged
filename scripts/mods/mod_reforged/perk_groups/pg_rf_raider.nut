::Reforged.PerkGroups.Raider <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_raider";
		this.Name = "Raider";
		this.Icon = "ui/perk_groups/rf_raider.png";
		this.FlavorText = [
			"raided villages and caravans",
			"is a well-known raider and looter in this area"
		];
		this.Tree = [
			["perk.rf_menacing"],
			[],
			[],
			[],
			[],
			["perk.rf_bully"],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_vicious": 3
		};
	}
};
