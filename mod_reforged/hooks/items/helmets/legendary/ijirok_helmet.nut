::Reforged.HooksMod.hook("scripts/items/helmets/legendary/ijirok_helmet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Vision = -3;	// In Vanilla this is 0
	}
});
