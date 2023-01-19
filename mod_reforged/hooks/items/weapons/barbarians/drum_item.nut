::mods_hookExactClass("items/weapons/barbarians/drum_item", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;
	}
});
