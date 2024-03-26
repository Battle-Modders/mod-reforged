::Reforged.HooksMod.hook("scripts/items/accessory/iron_will_potion_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 225;
	}
});
