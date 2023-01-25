this.pg_rf_trapper <- ::inherit(::DPF.Class.PerkGroup, {
	m = {},
	function create()
	{
		this.m.ID = "pg.rf_trapper";
		this.m.Name = "Trapper";
		this.m.FlavorText = [
			"has experience in trapping and using nets"
		];
		this.m.Trees = {
			"default": [
				[],
				["perk.rf_trip_artist"],
				[],
				["perk.rf_offhand_training"],
				["perk.rf_angler"],
				[],
				["perk.rf_kingfisher"]
			]
		};
	}
});
