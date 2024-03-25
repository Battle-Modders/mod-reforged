::Reforged.HooksMod.hook("scripts/items/accessory/spider_poison_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 100;
	}
});
