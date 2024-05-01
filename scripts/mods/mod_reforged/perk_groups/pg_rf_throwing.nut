this.pg_rf_throwing <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_throwing";
		this.m.Name = "Throwing";
		this.m.Icon = "ui/perk_groups/rf_throwing.png";
		this.m.FlavorText = [
			"throwing weapons"
		];
		this.m.Trees = {
			"default": [
				[],
				[],
				["perk.rf_hybridization"],
				["perk.mastery.throwing"],
				["perk.rf_opportunist"],
				[],
				[]
			]
		};
	}
});
