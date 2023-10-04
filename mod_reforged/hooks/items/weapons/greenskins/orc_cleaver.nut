::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_cleaver", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
	}
});
