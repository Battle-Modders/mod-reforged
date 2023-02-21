::mods_hookExactClass("items/shields/ancient/coffin_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 24;
		this.m.ConditionMax = 24;
	}
});
