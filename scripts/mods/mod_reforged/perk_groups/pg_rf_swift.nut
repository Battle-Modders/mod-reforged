this.pg_rf_swift <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_swift";
		this.m.Name = "Swift Strikes";
		this.m.Icon = "ui/perk_groups/rf_swift.png";
		this.m.FlavorText = [
			"swift weapons"
		];
		this.m.Trees = {
			"default": [
				["perk.pathfinder"],
				["perk.rf_vigorous_assault"],
				[],
				["perk.rf_offhand_training"],
				[],
				["perk.duelist"],
				[]
			]
		};
	}
});
