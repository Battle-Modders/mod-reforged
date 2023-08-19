::mods_hookExactClass("items/helmets/greatsword_faction_helm", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2000;
	}
});
