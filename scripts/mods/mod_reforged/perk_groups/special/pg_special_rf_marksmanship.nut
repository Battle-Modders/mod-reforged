this.pg_special_rf_marksmanship <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_marksmanship";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_marksmanship.png";
		this.m.Chance = 10;
		this.m.Tree = [
			[],
			[],
			[],
			[],
			[],
			[],
			["perk.rf_marksmanship"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_ranged"))
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 ? 0 : talents[::Const.Attributes.RangedSkill];
	}
});
