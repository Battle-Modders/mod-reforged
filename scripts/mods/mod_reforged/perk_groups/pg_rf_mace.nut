this.pg_rf_mace <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_mace";
		this.m.Name = "Mace";
		this.m.Icon = "ui/perk_groups/rf_mace.png";
		this.m.Tree = [
			[],
			["perk.rf_concussive_strikes"],
			[],
			["perk.mastery.mace"],
			[],
			[],
			["perk.rf_bone_breaker"]
		];
	}
});
