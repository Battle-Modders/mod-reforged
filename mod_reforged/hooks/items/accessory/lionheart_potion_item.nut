::Reforged.HooksMod.hook("scripts/items/accessory/lionheart_potion_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 225;
	}
});
