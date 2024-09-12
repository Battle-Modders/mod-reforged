::Reforged.HooksMod.hook("scripts/items/weapons/throwing_spear", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
