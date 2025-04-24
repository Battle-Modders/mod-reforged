::Reforged.HooksMod.hook("scripts/items/accessory/warhound_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -3;
	}

	q.getStaminaModifier = @() function()
	{
		return this.isUnleashed() ? 0 : this.accessory.getStaminaModifier();
	}
});
