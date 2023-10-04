::Reforged.HooksMod.hook("scripts/items/weapons/war_bow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
