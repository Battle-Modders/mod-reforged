::Reforged.PerkGroups.Militia <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_militia";
		this.Name = "Militia";
		this.Icon = "ui/perk_groups/rf_militia.png";
		this.FlavorText = [
			"served in the local militia",
			"was a member of local militia",
			"has combat experience from serving in the militia"
		];
		this.Tree = [
			[],
			["perk.rf_strength_in_numbers"],
			[],
			[],
			[],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_tactician": 1.5,
			"pg.rf_trained": 2,
			"pg.rf_spear": -1
		};
	}
};
