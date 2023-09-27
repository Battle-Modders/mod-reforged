::Reforged.HooksMod.hook("scripts/items/weapons/masterwork_bow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
