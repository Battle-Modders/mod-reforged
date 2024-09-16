::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_double_layer_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
	}
});
