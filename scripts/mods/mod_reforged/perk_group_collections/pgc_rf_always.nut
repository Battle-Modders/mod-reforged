this.pgc_rf_always <- ::inherit(::DPF.Class.PerkGroupCollection, {
	m = {},
	function create()
	{
		this.m.ID = "pgc.rf_always";
		this.m.Name = "General";
		this.m.OrderOfAssignment = 1;
		this.m.Min = 1;
		this.m.TooltipPrefix = "";
		this.m.Groups = [
			"pg.rf_always_1"
		];
	}
});
