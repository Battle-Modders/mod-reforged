this.pg_rf_trained <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_trained";
		this.m.Name = "Trained";
		this.m.Icon = "ui/perk_groups/rf_trained.png";
		this.m.Tree = [
			[],
			["perk.quick_hands"],
			["perk.rotation"],
			["perk.rf_vigilant"],
			["perk.underdog"],
			["perk.rf_finesse"],
			["perk.rf_weapon_master"]
		];
	}

	function getSelfMultiplier( _perkTree )
	{
		local talents = _perkTree.getActor().getTalents();
		return talents.len() == 0 ? 0.5 : 0.5 * ::Math.max(1, talents[::Const.Attributes.MeleeDefense]) * 1.2;
	}
});
