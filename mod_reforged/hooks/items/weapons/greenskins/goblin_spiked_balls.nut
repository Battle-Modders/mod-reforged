::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_spiked_balls", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
