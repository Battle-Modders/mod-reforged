::mods_hookExactClass("items/shields/special/craftable_lindwurm_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.ReachIgnore = 3;
	}
});
