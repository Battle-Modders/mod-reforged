::Reforged.PerkGroups.Agile <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_agile";
		this.Name = "Agile";
		this.Icon = "ui/perk_groups/rf_agile.png";
		this.FlavorText = [
			"is agile",
			"moves with grace and agility",
			"is naturally agile",
			"is impressively agile",
			"has an agile physique",
			"is agile like a fox",
			"is particularly agile"
		];
		this.Tree = [
			["perk.pathfinder"],
			["perk.anticipation"],
			[],
			[],
			["perk.footwork"],
			["perk.rf_fresh_and_furious"],
			["perk.battle_flow"]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
};
