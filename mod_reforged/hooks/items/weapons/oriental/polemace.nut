::Reforged.HooksMod.hook("scripts/items/weapons/oriental/polemace", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
		this.m.PoiseDamage = 120;
	}
});
