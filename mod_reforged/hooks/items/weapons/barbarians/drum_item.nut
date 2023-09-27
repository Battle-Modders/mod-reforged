::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/drum_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}
});
