::mods_hookExactClass("skills/effects/captain_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = true;		// This effect is now only added during combats with a captain present
	}
});
