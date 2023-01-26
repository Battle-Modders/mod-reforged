this.pg_rf_militia <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_militia";
		this.m.Name = "Militia";
		this.m.Icon = "ui/perks/rf_strength_in_numbers.png";
		this.m.FlavorText = [
			"served in the local militia",
			"was a member of local militia",
			"has combat experience from serving in the militia"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rf_strength_in_numbers"],
				[],
				[],
				[],
				[],
				[]
			]
		};
		this.m.PerkTreeMultipliers = {
			"pg.rf_tactician": 1.5,
			"pg.rf_trained": 2,
			"pg.rf_spear": -1
		};
	}
});
