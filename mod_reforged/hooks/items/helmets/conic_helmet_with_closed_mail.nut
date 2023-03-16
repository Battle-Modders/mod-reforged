::mods_hookExactClass("items/helmets/conic_helmet_with_closed_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2800;
		this.m.Condition = 275;
		this.m.ConditionMax = 275;
	}
});
