::Reforged.HooksMod.hook("scripts/skills/actives/rotation", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.FatigueCost = 20;
	}}.create;
});
