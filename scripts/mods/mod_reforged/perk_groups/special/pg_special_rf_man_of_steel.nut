this.pg_special_rf_man_of_steel <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_man_of_steel";
		this.m.Name = "Special Perks";
		this.m.Icon = "ui/perk_groups/rf_man_of_steel.png";
		this.m.FlavorText = [
			"Is tough as if made of steel!"
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
				["perk.rf_man_of_steel"]
			]
		};
	}

	function getMultiplier( _perkTree )
	{
		if (!_perkTree.hasPerkGroup("pg.rf_heavy_armor"))
			return 0;

		local talents = _perkTree.getActor().getTalents();

		return talents.len() == 0 ? 0 : talents[::Const.Attributes.Fatigue];
	}
});
