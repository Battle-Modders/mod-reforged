::mods_hookExactClass("items/weapons/battle_whip", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;
	}
});
