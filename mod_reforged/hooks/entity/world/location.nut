::mods_hookExactClass("entity/world/location", function(o) {
	local onLeave = o.onLeave;
	o.onLeave = function()
	{
		onLeave();
		::World.State.setPause(true);
	}
});