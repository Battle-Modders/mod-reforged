::Reforged.HooksMod.hook("scripts/items/weapons/longaxe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
		this.m.ShieldDamage = 32;
	}
});
