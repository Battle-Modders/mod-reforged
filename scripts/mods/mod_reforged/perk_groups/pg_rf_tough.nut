this.pg_rf_tough <- ::inherit(::DynamicPerks.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_tough";
		this.m.Name = "Tough";
		this.m.Icon = "ui/perk_groups/rf_tough.png";
		this.m.Tree = [
			["perk.colossus"],
			["perk.steel_brow"],
			["perk.taunt"],
			[],
			["perk.rf_vanquisher"],
			["perk.rf_second_wind"],
			["perk.killing_frenzy"]
		];
		this.m.PerkTreeMultipliers = {
			"pg.rf_power": 1.2
		};
	}
});
