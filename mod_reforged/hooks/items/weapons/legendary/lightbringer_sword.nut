::mods_hookExactClass("items/weapons/legendary/lightbringer_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}
});
