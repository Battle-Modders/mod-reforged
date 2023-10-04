::Reforged.HooksMod.hook("scripts/items/weapons/throwing_axe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
