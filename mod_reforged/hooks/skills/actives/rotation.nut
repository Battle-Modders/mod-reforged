::mods_hookExactClass("skills/actives/rotation", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.FatigueCost = 20;
	}
});
