this.pg_rf_mace <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_mace";
		this.m.Name = "Mace";
		this.m.Icon = "ui/perks/perk_43.png"; // mace mastery icon
		this.m.FlavorText = [
			"maces"
		];
		this.m.Trees = {
			"default": [
				["perk.rf_rattle"],
				[],
				["perk.rf_bear_down"],
				["perk.mastery.mace"],
				["perk.rf_concussive_strikes"],
				[],
				["perk.rf_bone_breaker"]
			]
		};
	}
});
