this.pg_special_rf_proximity_specialist <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_proximity_specialist";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_proximity_specialist.png";
		this.m.FlavorText = [
			"Likes to use ranged weapons at close range."
		];
		this.m.Chance = 10;
		this.m.Trees = {
			"default": [
				[],
				[],
				[],
				[],
				[],
				[],
				["perk.rf_proximity_throwing_specialist"]
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
