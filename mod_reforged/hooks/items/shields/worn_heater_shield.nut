::Reforged.HooksMod.hook("scripts/items/shields/worn_heater_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ReachIgnore = 3;
	}
});
