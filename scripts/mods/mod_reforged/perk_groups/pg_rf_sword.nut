this.pg_rf_sword <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_sword";
		this.m.Name = "Sword";
		this.m.Icon = "ui/perks/perk_46.png"; // sword mastery icon
		this.m.FlavorText = [
			"swords"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rf_exploit_opening"],
				["perk.rf_fluid_weapon"],
				["perk.mastery.sword"],
				["perk.rf_tempo"],
				["perk.rf_kata"],
				["perk.rf_en_garde"]
			]
		};
	}

	function getSelfMultiplier( _perkTree )
	{
		return 1.2;
	}
});
