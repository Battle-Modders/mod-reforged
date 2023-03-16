::mods_hookExactClass("items/helmets/conic_helmet_with_faceguard", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 290;
		this.m.ConditionMax = 290;
	}
});
