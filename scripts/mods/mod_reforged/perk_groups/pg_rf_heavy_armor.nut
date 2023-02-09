::Reforged.PerkGroups.HeavyArmor <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_heavy_armor";
		this.Name = "Heavy Armor";
		this.Icon = "ui/perk_groups/rf_heavy_armor.png";
		this.FlavorText = [
			"heavy armor"
		];
		this.Tree = [
			[],
			[],
			["perk.brawny"],
			[],
			["perk.rf_bulwark"],
			["perk.battle_forged"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.5;
	}
};
