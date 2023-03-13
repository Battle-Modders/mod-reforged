::mods_hookExactClass("skills/actives/unleash_wardog", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Order = ::Const.SkillOrder.BeforeLast + 5;	// We want release-ables to be listed after break-free skills (which are BeforeLast)
	}
});
