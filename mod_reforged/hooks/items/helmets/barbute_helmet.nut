::mods_hookExactClass("items/helmets/barbute_helmet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2000;
	}
});
