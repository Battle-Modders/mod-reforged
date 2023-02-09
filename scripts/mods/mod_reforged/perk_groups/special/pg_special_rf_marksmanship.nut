::Reforged.PerkGroups.Marksmanship <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_marksmanship";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_marksmanship.png";
		this.FlavorText = [
			"Has the talent to become a formidable marksman."
		];
		this.Chance = 20;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_marksmanship"]
		];
	}

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_ranged"))
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 || talents[::Const.Attributes.RangedSkill] < 2 ? 0 : talents[::Const.Attributes.RangedSkill];
	}
};
