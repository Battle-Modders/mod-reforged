::Reforged.PerkGroups.ManOfSteel <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_man_of_steel";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_man_of_steel.png";
		this.FlavorText = [
			"Is tough as if made of steel!"
		];
		this.Chance = 25;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_man_of_steel"]
		];
	}

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_heavy_armor"))
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 ? 0 : talents[::Const.Attributes.Fatigue];
	}
};
