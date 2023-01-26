this.pg_rf_axe <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_axe";
		this.m.Name = "Axe";
		this.m.Icon = "ui/perks/perk_44.png" // axe mastery icon
		this.m.FlavorText = [
			"axes"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_shield_splitter"],
				[],
				[],
				["perk.mastery.axe"],
				["perk.rf_between_the_eyes"],
				["perk.rf_heft"],
				["perk.rf_cull"]
			]
		};
	}
});
