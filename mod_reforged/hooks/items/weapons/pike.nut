::Reforged.HooksMod.hook("scripts/items/weapons/pike", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.Reach = 7;
	}
});
