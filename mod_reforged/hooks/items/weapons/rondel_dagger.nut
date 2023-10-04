::Reforged.HooksMod.hook("scripts/items/weapons/rondel_dagger", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}
});
