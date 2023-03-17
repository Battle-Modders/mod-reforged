::mods_hookExactClass("skills/effects/battle_standard_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = true;		// This effect is now only added during combats with a banner present
	}
});
