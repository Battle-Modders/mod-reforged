::mods_hookExactClass("skills/effects/dodge_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IconMini = "";	// Dodge is a permanent passive effect. Therefore it does not deserve a spot among the mini-icons in favor of way more important effects
		// Don't remove after battle as we have now changed perk_dodge to add this effect in onAdded
		// so that it is visible and applies its effects even on the world map
		this.m.IsRemovedAfterBattle = false;
	}
});
