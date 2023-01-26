this.pg_rf_fast <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_fast";
		this.m.Name = "Fast";
		this.m.Icon = "ui/perks/perk_26.png"; // relentless icon
		this.m.FlavorText = [
			"is fast",
			"runs fast",
			"is fast like a flash",
			"has fast feet",
			"maneuvers fast",
			"has fast steps",
			"is a fast sprinter"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.quick_hands"],
				["perk.relentless"],
				[],
				[],
				["perk.overwhelm"],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_swift": 1.2
		};
	}
});
