::mods_hookExactClass("items/tools/faction_banner", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
