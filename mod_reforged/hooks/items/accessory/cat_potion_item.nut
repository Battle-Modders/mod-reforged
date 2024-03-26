::Reforged.HooksMod.hook("scripts/items/accessory/cat_potion_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 250;
	}
});
