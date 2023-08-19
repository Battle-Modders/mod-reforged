::mods_hookExactClass("items/helmets/greatsword_hat", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 1000;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
	}
});
