::Reforged.PerkGroups.Fencer <- class extends ::DynamicPerks.Class.SpecialPerkGroup
{
	constructor()
	{
		this.ID = "pg.special.rf_fencer";
		this.Name = "Special Perks";
		this.Icon = "ui/perk_groups/rf_fencer.png";
		this.FlavorText = [
			"Has all the makings of a capable fencer."
		];
		this.Chance = 25;
		this.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_fencer"]
		];
	}

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_sword"))
			return 0;

		if (_perkTree.getActor().getBaseProperties().Initiative * _perkTree.getActor().getBaseProperties().InitiativeMult < 100)
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 ? 0 : talents[::Const.Attributes.Initiative] * talents[::Const.Attributes.MeleeSkill];
	}
};
