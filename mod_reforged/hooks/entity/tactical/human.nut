::Reforged.HooksMod.hook("scripts/entity/tactical/human", function(q) {
	q.onInit = @(__original) function()
	{
		__original();
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
	}
});
