this.pg_special_rf_marksmanship <- ::inherit(::DPF.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_marksmanship";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perks/rf_marksmanship.png";
		this.m.FlavorText = [
			"Has the talent to become a formidable marksman."
		];
		this.m.Chance = 20;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_marksmanship"]
			]
		};
	}

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_ranged"))
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 || talents[::Const.Attributes.RangedSkill] < 2 ? 0 : talents[::Const.Attributes.RangedSkill];
	}
});
