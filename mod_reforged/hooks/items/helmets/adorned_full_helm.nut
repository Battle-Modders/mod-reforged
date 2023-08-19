::mods_hookExactClass("items/helmets/adorned_full_helm", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 4250;
	}
});
