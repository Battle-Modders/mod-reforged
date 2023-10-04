::Reforged.HooksMod.hook("scripts/items/helmets/adorned_full_helm", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 4250;
	}
});
