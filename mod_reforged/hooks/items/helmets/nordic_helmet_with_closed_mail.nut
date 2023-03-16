::mods_hookExactClass("items/helmets/nordic_helmet_with_closed_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2700;
		this.m.Condition = 270;
		this.m.ConditionMax = 270;
	}
});
