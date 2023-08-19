::mods_hookExactClass("items/helmets/sallet_helmet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Open Faced Sallet Helmet";
		this.m.Value = 1500;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
	}
});
