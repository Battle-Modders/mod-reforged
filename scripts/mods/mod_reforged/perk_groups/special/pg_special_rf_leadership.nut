this.pg_special_rf_leadership <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_leadership";
		this.m.Name = "Leadership";
		this.m.Icon = "ui/perk_groups/rf_leadership.png";
		this.m.Chance = 3;
		this.m.Tree = [
			["perk.rf_supporter"],
			["perk.rally_the_troops"],
			["perk.fortified_mind"],
			["perk.mastery.polearm"],
			["perk.rf_command"],
			[],
			["perk.inspiring_presence"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 1.0 : ::Math.max(1, talents[::Const.Attributes.Bravery]) * 2.0;
	}
});
