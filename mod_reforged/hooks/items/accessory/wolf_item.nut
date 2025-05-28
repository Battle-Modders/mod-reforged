::Reforged.HooksMod.hook("scripts/items/accessory/wolf_item", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.StaminaModifier = -3;
	}}.create;

	q.getStaminaModifier = @() { function getStaminaModifier()
	{
		return this.isUnleashed() ? 0 : this.accessory.getStaminaModifier();
	}}.getStaminaModifier;
});
