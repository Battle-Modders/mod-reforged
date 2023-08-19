::mods_hookExactClass("items/helmets/oriental/gladiator_helmet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
	}
});
