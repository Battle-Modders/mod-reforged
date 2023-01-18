::mods_hookExactClass("skills/effects/dodge_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		// Don't remove after battle as we have now changed perk_dodge to add this effect in onAdded
		// so that it is visible and applies its effects even on the world map
		this.m.IsRemovedAfterBattle = false;
	}
});
