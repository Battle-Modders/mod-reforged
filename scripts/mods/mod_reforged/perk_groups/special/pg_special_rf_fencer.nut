this.pg_special_rf_fencer <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_fencer";
		this.m.Name = "Special Perks";
		this.m.FlavorText = [
			"Has all the makings of a capable fencer."
		];
		this.m.Chance = 25;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_fencer"]
			]
		};
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
});
