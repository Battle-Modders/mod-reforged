::mods_hookExactClass("items/tools/player_banner", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
