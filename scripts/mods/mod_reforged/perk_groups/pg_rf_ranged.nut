::Reforged.PerkGroups.Ranged <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_ranged";
		this.Name = "Ranged Weapons";
		this.Icon = "ui/perk_groups/rf_ranged.png";
		this.FlavorText = [
			"ranged weapons"
		];
		this.Tree = [
			[],
			["perk.bullseye"],
			[],
			[],
			[],
			[],
			[]
		];
	}
};
