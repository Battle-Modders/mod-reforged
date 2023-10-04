::Reforged.HooksMod.hook("scripts/skills/actives/rotation", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 20;
	}
});
