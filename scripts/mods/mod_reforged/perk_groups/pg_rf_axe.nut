this.pg_rf_axe <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_axe";
		this.m.Name = "Axe";
		this.m.Icon = "ui/perk_groups/rf_axe.png";
		this.m.Tree = [
			[],
			["perk.rf_dismemberment"],
			[],
			["perk.mastery.axe"],
			[],
			[],
			["perk.rf_dismantle"]
		];
	}
});
