::Reforged.HooksMod.hook("scripts/items/weapons/arming_sword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}
});
