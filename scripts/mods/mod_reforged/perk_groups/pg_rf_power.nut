this.pg_rf_power <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_power";
		this.m.Name = "Powerful Strikes";
		this.m.Icon = "ui/perk_groups/rf_power.png";
		this.m.Tree = [
			["perk.crippling_strikes"],
			["perk.rf_vigorous_assault"],
			["perk.rf_leverage"],
			["perk.mastery.polearm"],
			["perk.rf_sweeping_strikes"],
			["perk.rf_long_reach"],
			["perk.rf_formidable_approach"]
		];
	}
});
