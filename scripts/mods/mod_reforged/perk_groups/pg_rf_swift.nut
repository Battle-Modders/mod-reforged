::Reforged.PerkGroups.Swift <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_swift";
		this.Name = "Swift Strikes";
		this.Icon = "ui/perk_groups/rf_swift.png";
		this.FlavorText = [
			"swift weapons"
		];
		this.Tree = [
			["perk.pathfinder"],
			["perk.rf_vigorous_assault"],
			[],
			["perk.rf_offhand_training"],
			[],
			["perk.duelist"],
			["perk.rf_weapon_master"]
		];
	}
};
