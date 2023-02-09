::Reforged.PerkGroups.LightArmor <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_light_armor";
		this.Name = "Light Armor";
		this.Icon = "ui/perk_groups/rf_light_armor.png";
		this.FlavorText = [
			"light armor"
		];
		this.Tree = [
			[],
			["perk.dodge"],
			["perk.relentless"],
			[],
			[],
			["perk.nimble"],
			[]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		return 0.66;
	}
};
